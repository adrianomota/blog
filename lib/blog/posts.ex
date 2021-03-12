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

  # alias Blog.Posts.Comment

  # @doc """
  # Returns the list of comments.

  # """
  # def list_comments do
  #   Repo.all(Comment)
  # end

  # @doc """
  # Gets a single comment.

  # Raises `Ecto.NoResultsError` if the Comment does not exist.

  # """
  # def get_comment!(id), do: Repo.get!(Comment, id)

  # @doc """
  # Creates a comment.

  # """
  # def create_comment(attrs \\ %{}) do
  #   %Comment{}
  #   |> Comment.changeset(attrs)
  #   |> Repo.insert()
  # end

  # @doc """
  # Updates a comment.

  # """
  # def update_comment(%Comment{} = comment, attrs) do
  #   comment
  #   |> Comment.changeset(attrs)
  #   |> Repo.update()
  # end

  # @doc """
  # Deletes a comment.

  # """
  # def delete_comment(%Comment{} = comment) do
  #   Repo.delete(comment)
  # end

  # @doc """
  # Returns an `%Ecto.Changeset{}` for tracking comment changes.

  # """
  # def change_comment(%Comment{} = comment, attrs \\ %{}) do
  #   Comment.changeset(comment, attrs)
  # end
end
