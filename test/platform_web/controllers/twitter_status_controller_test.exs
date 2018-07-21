defmodule PlatformWeb.TwitterStatusControllerTest do
  use PlatformWeb.ConnCase

  describe "#index" do
    setup :create_twitter_status

    test "lists all twitter_statuss", %{conn: conn, twitter_status: twitter_status} do
      conn = get conn, twitter_status_path(conn, :index)
      assert html_response(conn, 200) =~ twitter_status.screen_name
    end
  end

  describe "#show" do
    setup :create_twitter_status

    test "shows chosen resource", %{conn: conn, twitter_status: twitter_status} do
      conn = get conn, twitter_status_path(conn, :show, twitter_status)
      assert html_response(conn, 200) =~ twitter_status.screen_name
    end

    test "redirects page when id is nonexistent", %{conn: conn} do
      assert_error_sent 404, fn ->
        get conn, twitter_status_path(conn, :show, -1)
      end
    end
  end

  describe "#update" do
    setup :create_twitter_status

    test "redirects when rating is valid", %{conn: orig_conn, twitter_status: twitter_status} do
      conn = put orig_conn, twitter_status_path(orig_conn, :update, twitter_status), rating: 2
      assert redirected_to(conn) == twitter_status_path(conn, :show, twitter_status)

      conn = get orig_conn, twitter_status_path(orig_conn, :show, twitter_status)
      assert html_response(conn, 200) =~ "2"
    end

    test "redirects when unimportant is valid", %{conn: orig_conn, twitter_status: twitter_status} do
      conn = put orig_conn, twitter_status_path(orig_conn, :update, twitter_status), toggle: "unimportant"
      assert redirected_to(conn) == twitter_status_path(conn, :show, twitter_status)

      conn = get orig_conn, twitter_status_path(orig_conn, :show, twitter_status)
      assert html_response(conn, 200) =~ "Unimportant"
    end
  end

  # Private functions
  defp create_twitter_status(_) do
    twitter_status = Factory.insert(:twitter_status)
    {:ok, twitter_status: twitter_status}
  end
end
