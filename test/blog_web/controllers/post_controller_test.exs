defmodule BlogWeb.PostControllerTest do
  use BlogWeb.ConnCase

  @post_fixtures %{
    "title" => "post test",
    "description" => "loren"
  }

  test "GET /post", %{conn: conn} do
    Blog.Posts.create(@post_fixtures)

    conn = get(conn, Routes.post_path(conn, :index))

    assert html_response(conn, 200) =~ "post test"
  end

  test "GET /show", %{conn: conn} do
    {:ok, post} = Blog.Posts.create(@post_fixtures)

    conn = get(conn, Routes.post_path(conn, :show, post))

    assert html_response(conn, 200) =~ "post test"
  end

  test "GET /new", %{conn: conn} do
    conn = get(conn, Routes.post_path(conn, :new))
    assert html_response(conn, 200) =~ "Criar post"
  end

  test "POST /create", %{conn: conn} do
    conn = post(conn, Routes.post_path(conn, :create, post: @post_fixtures))
    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == Routes.post_path(conn, :show, id)

    conn = get(conn, Routes.post_path(conn, :show, id))
    assert html_response(conn, 200) =~ "Post criado com sucesso"
  end

  test "POST /create invalid", %{conn: conn} do
    conn = post(conn, Routes.post_path(conn, :create, post: %{"title" => "", "decription" => ""}))
    assert html_response(conn, 200) =~ "Campo obrigatório"
  end

  test "GET /edit", %{conn: conn} do
    {:ok, post} = Blog.Posts.create(@post_fixtures)
    conn = get(conn, Routes.post_path(conn, :edit, post))
    assert html_response(conn, 200) =~ "Editar post"
  end

  test "PUT /update", %{conn: conn} do
    {:ok, post} = Blog.Posts.create(%{"title" => "title", "description" => "description"})

    conn = put(conn, Routes.post_path(conn, :update, post), post: @post_fixtures)

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == Routes.post_path(conn, :show, id)

    conn = get(conn, Routes.post_path(conn, :show, id))
    assert html_response(conn, 200) =~ "Post atualizado com sucesso"
  end

  test "PUT /update invalid", %{conn: conn} do
    {:ok, post} = Blog.Posts.create(@post_fixtures)

    conn =
      put(conn, Routes.post_path(conn, :update, post), post: %{"title" => "", "description" => ""})

    assert html_response(conn, 200) =~ "Campo obrigatório"
    assert html_response(conn, 200) =~ "Editar post"
  end

  test "DELETE /delete invalid", %{conn: conn} do
    {:ok, post} = Blog.Posts.create(@post_fixtures)

    conn = delete(conn, Routes.post_path(conn, :delete, post))

    assert redirected_to(conn) == Routes.post_path(conn, :index)
  end
end
