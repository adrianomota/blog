defmodule BlogWeb.PostController do
  use BlogWeb, :controller

  alias Blog.{Posts.Post, Repo}

  def index(conn, _params) do
    posts = Repo.all(Post)

    render(conn, "index.html", posts: posts)
  end

  def show(conn, %{"id" => id}) do
    post = Repo.get(Post, id)
    render(conn, "show.html", post: post)
  end

  def new(conn, _params) do
    changeset = Post.changeset(%Post{})
    render(conn, "new.html", changeset: changeset)
  end

  def edit(conn, %{"id" => id}) do
    post_exists? = Repo.get(Post, id)

    if post_exists? != nil do
      changeset = Post.changeset(post_exists?)

      conn
      |> render("edit.html", post: post_exists?, changeset: changeset)
    else
      conn
      |> put_flash(:info, "Post não existe")
      |> render("index.html", posts: Repo.all(Post))
    end
  end

  def create(conn, %{"post" => post}) do
    new_post = Post.changeset(%Post{}, post)

    case Repo.insert(new_post) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post criado com sucesso")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "post" => post}) do
    post_exists? = Repo.get(Post, id)

    if post_exists? != nil do
      changeset = Post.changeset(post_exists?, post)

      case Repo.update(changeset) do
        {:ok, post} ->
          conn
          |> put_flash(:info, "Post atualizado com sucesso")
          |> redirect(to: Routes.post_path(conn, :show, post))

        {:error, changeset} ->
          render(conn, "new.html", changeset: changeset)
      end
    else
      conn
      |> put_flash(:info, "Impossível atualizar o Post")
      |> redirect(to: Routes.post_path(conn, :show, post))
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Repo.get(Post, id)

    if post != nil do
      Repo.delete!(post)

      conn
      |> put_flash(:info, "Post excluído com sucesso")
      |> redirect(to: Routes.post_path(conn, :index, Repo.all(Post)))
    else
      conn
      |> put_flash(:error, "Post não existe!")
      |> render("index.html", posts: Repo.all(Post))
    end
  end
end
