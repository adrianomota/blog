defmodule BlogWeb.PostController do
  use BlogWeb, :controller

  def index(conn, _params) do
    posts = Blog.Posts.list()

    render(conn, "index.html", posts: posts)
  end

  def show(conn, %{"id" => id}) do
    post = Blog.Posts.get(id)
    render(conn, "show.html", post: post)
  end

  def new(conn, _params) do
    changeset = Blog.Posts.get()
    render(conn, "new.html", changeset: changeset)
  end

  def edit(conn, %{"id" => id}) do
    post_exists? = Blog.Posts.get(id)

    if post_exists? != nil do
      changeset = Blog.Posts.get_changeset(post_exists?)

      conn
      |> render("edit.html", post: post_exists?, changeset: changeset)
    else
      conn
      |> put_flash(:info, "Post não existe")
      |> render("index.html", posts: Blog.Posts.list())
    end
  end

  def create(conn, %{"post" => post}) do
    case Blog.Posts.create(post) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post criado com sucesso")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "post" => params}) do
    post_exists? = Blog.Posts.get(id)

    case Blog.Posts.update(post_exists?, params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post atualizado com sucesso")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, changeset} ->
        render(conn, "edit.html", changeset: changeset, post: post_exists?)
    end
  end

  def delete(conn, %{"id" => id}) do
    case Blog.Posts.delete(id) do
      {:ok, _post} ->
        conn
        |> put_flash(:info, "Post excluído com sucesso")
        |> redirect(to: Routes.post_path(conn, :index, Blog.Posts.list()))

      {:error, changeset} ->
        conn
        |> put_flash(:error, "Post não existe!")
        |> render("index.html", changeset: changeset, posts: Blog.Posts.list())
    end
  end
end
