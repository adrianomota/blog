defmodule Blog.PostsTest do
  use Blog.DataCase, async: true

  alias Blog.Posts

  describe "create/1" do
    test "when thre are title and description post, returns a valid post" do
      params = %{
        title: "post 1",
        description: "loren"
      }

      {:ok, post} = Posts.create(params)

      assert params.title == post.title
      assert params.description == post.description
    end
  end
end
