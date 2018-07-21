defmodule PlatformWeb.ExchangeControllerTest do
  use PlatformWeb.ConnCase

  @create_attrs Factory.params_for(:exchange)
  @update_attrs %{name: "HitBTC"}
  @invalid_attrs %{name: ""}

  setup :login_as_admin

  describe "#index" do
    setup :create_exchange

    test "lists all exchanges", %{conn: conn, exchange: exchange} do
      conn = get conn, exchange_path(conn, :index)
      assert html_response(conn, 200) =~ exchange.name
    end
  end

  describe "#new" do
    test "renders form", %{conn: conn} do
      conn = get conn, exchange_path(conn, :new)
      assert html_response(conn, 200) =~ "New exchange"
    end
  end

  describe "#create" do
    test "redirects to show when data is valid", %{conn: orig_conn} do
      conn = post orig_conn, exchange_path(orig_conn, :create), exchange: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == exchange_path(conn, :show, id)

      conn = get orig_conn, exchange_path(orig_conn, :show, id)
      assert html_response(conn, 200) =~ @create_attrs.name
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, exchange_path(conn, :create), exchange: @invalid_attrs
      assert html_response(conn, 200) =~ "New exchange"
    end
  end

  describe "#edit" do
    setup :create_exchange

    test "renders form for editing chosen exchange", %{conn: conn, exchange: exchange} do
      conn = get conn, exchange_path(conn, :edit, exchange)
      assert html_response(conn, 200) =~ "Edit exchange"
    end
  end

  describe "#update" do
    setup :create_exchange

    test "redirects when data is valid", %{conn: orig_conn, exchange: exchange} do
      conn = put orig_conn, exchange_path(orig_conn, :update, exchange), exchange: @update_attrs
      assert redirected_to(conn) == exchange_path(conn, :show, exchange)

      conn = get orig_conn, exchange_path(orig_conn, :show, exchange)
      assert html_response(conn, 200) =~ @update_attrs.name
    end

    test "renders errors when data is invalid", %{conn: conn, exchange: exchange} do
      conn = put conn, exchange_path(conn, :update, exchange), exchange: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit exchange"
    end
  end

  describe "#delete" do
    setup :create_exchange

    test "deletes chosen exchange", %{conn: orig_conn, exchange: exchange} do
      conn = delete orig_conn, exchange_path(orig_conn, :delete, exchange)
      assert redirected_to(conn) == exchange_path(conn, :index)
      assert_error_sent 404, fn ->
        get orig_conn, exchange_path(orig_conn, :show, exchange)
      end
    end
  end

  # Private functions
  defp create_exchange(_) do
    exchange = Factory.insert(:exchange)
    {:ok, exchange: exchange}
  end
end
