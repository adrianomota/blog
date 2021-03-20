defmodule BlogWeb.CommentsChannelTest do
  @moduledoc """
  CommentsChannelTest module
  """
  use BlogWeb.ChannelCase

  alias BlogWeb.UserSocket

  @valid_attrs_post %{
    title: "title",
    description: "my descruption"
  }

  describe "comments" do
    setup do
      {:ok, post} = Blog.Posts.create(@valid_attrs_post)

      {:ok, socket} = connect(UserSocket, %{})

      {:ok, socket: socket, post: post}
    end

    test "deve se conectar ao socket", %{socket: socket, post: post} do
      {:ok, result, socket} = subscribe_and_join(socket, "comments:#{post.id}", %{})

      assert post.id == socket.assigns.post_id

      assert [] == result.comments
    end

    test "Deve criar m comentario", %{socket: socket, post: post} do
      {:ok, _result, socket} = subscribe_and_join(socket, "comments:#{post.id}", %{})

      ref = push(socket, "comment:add", %{"content" => "abcd"})

      assert_reply ref, :ok, %{}

      broadcast_event = "comments:#{post.id}:new"

      assert_broadcast broadcast_event, %{comment: %{content: "abcd"}}
    end
  end
end
