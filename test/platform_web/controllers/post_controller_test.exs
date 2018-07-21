defmodule PlatformWeb.PostControllerTest do
  use PlatformWeb.ConnCase

  @create_attrs Factory.params_for(:post)
  @update_attrs %{title: "Blockchain Advanced"}
  @invalid_attrs %{title: ""}

  setup :login_as_admin

  describe "#index" do
    setup :create_post

    test "lists all posts", %{conn: conn, post: post} do
      conn = get conn, post_path(conn, :index)
      assert html_response(conn, 200) =~ post.title
    end
  end

  describe "#new" do
    test "renders form", %{conn: conn} do
      conn = get conn, post_path(conn, :new)
      assert html_response(conn, 200) =~ "New post"
    end
  end

  describe "#create" do
    test "redirects to show when data is valid", %{conn: orig_conn} do
      conn = post orig_conn, post_path(orig_conn, :create), post: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == post_path(conn, :show, id)

      conn = get orig_conn, post_path(orig_conn, :show, id)
      assert html_response(conn, 200) =~ @create_attrs.title
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, post_path(conn, :create), post: @invalid_attrs
      assert html_response(conn, 200) =~ "New post"
    end
  end

  describe "#edit" do
    setup :create_post

    test "renders form for editing chosen post", %{conn: conn, post: post} do
      conn = get conn, post_path(conn, :edit, post)
      assert html_response(conn, 200) =~ "Edit post"
    end
  end

  describe "#update" do
    setup :create_post

    test "redirects when data is valid", %{conn: orig_conn, post: post} do
      conn = put orig_conn, post_path(orig_conn, :update, post), post: @update_attrs
      assert redirected_to(conn) == post_path(conn, :show, post)

      conn = get orig_conn, post_path(orig_conn, :show, post)
      assert html_response(conn, 200) =~ @update_attrs.title
    end

    test "renders errors when data is invalid", %{conn: conn, post: post} do
      conn = put conn, post_path(conn, :update, post), post: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit post"
    end
  end

  describe "#delete" do
    setup :create_post

    test "deletes chosen post", %{conn: orig_conn, post: post} do
      conn = delete orig_conn, post_path(orig_conn, :delete, post)
      assert redirected_to(conn) == post_path(conn, :index)
      assert_error_sent 404, fn ->
        get orig_conn, post_path(orig_conn, :show, post)
      end
    end
  end

  # Private functions
  defp create_post(_) do
    post = Factory.insert(:post)
    {:ok, post: post}
  end
end
