defmodule BlogWeb.CommentsChannel do
  @moduledoc """
    Comments channel module
  """
  use BlogWeb, :channel

  def join("comments:" <> post_id, _payload, socket) do
    post = Blog.Posts.get_with_comments(post_id)

    {:ok, %{comments: post.comments}, socket}
  end

  def handle_in() do
    {:ok}
  end
end
