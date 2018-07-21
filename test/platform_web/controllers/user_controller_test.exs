defmodule PlatformWeb.UserControllerTest do
  use PlatformWeb.ConnCase

  @update_attrs %{name: "John Doe"}
  @invalid_attrs %{name: ""}

  describe "#index" do
    setup :create_user

    test "lists all users", %{conn: conn, user: user} do
      conn = get conn, user_path(conn, :index)
      assert html_response(conn, 200) =~ user.name
    end
  end

  describe "#show" do
    setup :create_user

    test "shows chosen resource", %{conn: conn, user: user} do
      conn = get conn, user_path(conn, :show, user)
      assert html_response(conn, 200) =~ user.name
    end

    test "redirects page when id is nonexistent", %{conn: conn} do
      assert_error_sent 404, fn ->
        get conn, user_path(conn, :show, -1)
      end
    end
  end

  describe "#edit" do
    setup :create_user

    test "renders form for editing chosen user", %{conn: conn, user: user} do
      conn = get conn, user_path(conn, :edit, user)
      assert html_response(conn, 200) =~ "Edit user"
    end
  end

  describe "#update" do
    setup :create_user

    test "redirects when data is valid", %{conn: orig_conn, user: user} do
      conn = put orig_conn, user_path(orig_conn, :update, user), user: @update_attrs
      assert redirected_to(conn) == user_path(conn, :show, user)

      conn = get orig_conn, user_path(orig_conn, :show, user)
      assert html_response(conn, 200) =~ @update_attrs.name
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put conn, user_path(conn, :update, user), user: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit user"
    end
  end

  # Private functions
  defp create_user(_) do
    user = Factory.insert(:user)
    {:ok, user: user}
  end
end
