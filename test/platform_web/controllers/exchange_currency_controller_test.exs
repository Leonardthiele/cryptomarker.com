defmodule PlatformWeb.ExchangeCurrencyControllerTest do
  use PlatformWeb.ConnCase

#   @create_attrs %{active: true, currency_id: "some currency_id", symbol: "some symbol"}
#   @update_attrs %{active: false, currency_id: "some updated currency_id", symbol: "some updated symbol"}
  @invalid_attrs %{currency_id: nil}

  setup :login_as_admin
  setup :create_exchange

  describe "#new" do
    test "renders form", %{conn: conn, exchange: exchange} do
      conn = get conn, exchange_exchange_currency_path(conn, :new, exchange)
      assert html_response(conn, 200) =~ "New exchange currency"
    end
  end

  describe "#create" do
#     test "redirects to show when data is valid", %{conn: conn, exchange: exchange} do
#       conn = post conn, exchange_exchange_currency_path(conn, :create), exchange_currency: @create_attrs

#       assert %{id: id} = redirected_params(conn)
#       assert redirected_to(conn) == exchange_exchange_currency_path(conn, :show, id)

#       conn = get conn, exchange_exchange_currency_path(conn, :show, id)
#       assert html_response(conn, 200) =~ "Show Exchange currency"
#     end

    test "renders errors when data is invalid", %{conn: conn, exchange: exchange} do
      conn = post conn, exchange_exchange_currency_path(conn, :create, exchange), exchange_currency: @invalid_attrs
      assert html_response(conn, 200) =~ "New exchange currency"
    end
  end

  describe "#edit" do
    setup :create_exchange_currency

    test "renders form for editing chosen exchange_currency", %{conn: conn, exchange: exchange, exchange_currency: exchange_currency} do
      conn = get conn, exchange_exchange_currency_path(conn, :edit, exchange, exchange_currency)
      assert html_response(conn, 200) =~ "Edit exchange currency"
    end
  end

#   describe "#update" do
#     setup :create_exchange_currency

#     test "redirects when data is valid", %{conn: conn, exchange: exchange, exchange_currency: exchange_currency} do
#       conn = put conn, exchange_exchange_currency_path(conn, :update, exchange_currency), exchange_currency: @update_attrs
#       assert redirected_to(conn) == exchange_exchange_currency_path(conn, :show, exchange_currency)

#       conn = get conn, exchange_exchange_currency_path(conn, :show, exchange_currency)
#       assert html_response(conn, 200) =~ "some updated currency_id"
#     end

#     test "renders errors when data is invalid", %{conn: conn, exchange_currency: exchange_currency} do
#       conn = put conn, exchange_exchange_currency_path(conn, :update, exchange_currency), exchange_currency: @invalid_attrs
#       assert html_response(conn, 200) =~ "Edit Exchange currency"
#     end
#   end

  describe "#delete" do
    setup :create_exchange_currency

    test "deletes chosen exchange_currency", %{conn: orig_conn, exchange: exchange, exchange_currency: exchange_currency} do
      conn = delete orig_conn, exchange_exchange_currency_path(orig_conn, :delete, exchange, exchange_currency)
      assert redirected_to(conn) == exchange_path(conn, :show, exchange)

      conn = get orig_conn, exchange_path(orig_conn, :show, exchange)
      refute html_response(conn, 200) =~ exchange_currency.currency.name
    end
  end

  # Private functions
  defp create_exchange(_) do
    exchange = Factory.insert(:exchange)
    {:ok, exchange: exchange}
  end

  defp create_exchange_currency(%{exchange: exchange}) do
    exchange_currency = Factory.insert(:exchange_currency, exchange: exchange)
    {:ok, exchange_currency: exchange_currency}
  end
end
