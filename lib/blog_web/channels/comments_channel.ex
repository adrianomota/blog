defmodule BlogWeb.CommentsChannel do
  @moduledoc """
    Comments channel module
  """
  use BlogWeb, :channel

  def join("comments:" <> post_id, _payload, socket) do
    post = Blog.Posts.get_with_comments(post_id)
    {:ok, %{comments: post.comments}, assign(socket, :post_id, post.id)}
  end

  def handle_in("comment:add", content, socket) do
    response =
      socket.assigns.post_id
      |> Blog.Comments.create_comment(content)

    case response do
      {:ok, comment} ->
        broadcast!(socket, "comments:#{socket.assigns.post_id}:new", %{comment: comment})
        {:reply, :ok, socket}

      {:error, changeset} ->
        {:reply, {:error, errors_on(changeset)}, socket}
    end
  end

  defp errors_on(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {message, opts} ->
      Regex.replace(~r"%{(\w+)}", message, fn _, key ->
        opts |> Keyword.get(String.to_existing_atom(key), key) |> to_string()
      end)
    end)
  end
end
