defmodule Blog.Posts do
  @moduledoc """
  Posts module
  """
  alias Blog.{Posts.Post, Repo}

  def list do
    Repo.all(Post)
  end

  def get_changeset(%Post{} = post) when is_struct(post), do: Post.changeset(post)

  def get(id), do: Repo.get(Post, id)

  def get, do: Post.changeset(%Post{})

  def create(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  def update(post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  def delete(id) do
    id
    |> get()
    |> Repo.delete()
  end
end
