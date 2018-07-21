defmodule PlatformWeb.PageControllerTest do
  use PlatformWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert redirected_to(conn) == currency_path(conn, :index)
  end
end
