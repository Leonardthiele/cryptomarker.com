defmodule PlatformWeb.CandleControllerTest do
  use PlatformWeb.ConnCase

#   @create_attrs Factory.params_for(:candle)
#   @update_attrs %{close: 456.7, high: 456.7, low: 456.7, open: 456.7, start: 43, trades: 43, volume: 456.7, vwp: 456.7}
#   @invalid_attrs %{close: nil, high: nil, low: nil, open: nil, start: nil, trades: nil, volume: nil, vwp: nil}

  setup :login_as_admin
  setup :create_currency

  describe "index" do
    setup :create_candle

    test "lists all candles", %{conn: conn, currency: currency} do
      conn = get conn, currency_candle_path(conn, :index, currency)
      assert html_response(conn, 200) =~ "Candles"
    end
  end

#   describe "create candle" do
#     test "redirects to show when data is valid", %{conn: conn} do
#       conn = post conn, candle_path(conn, :create), candle: @create_attrs

#       assert %{id: id} = redirected_params(conn)
#       assert redirected_to(conn) == candle_path(conn, :show, id)

#       conn = get conn, candle_path(conn, :show, id)
#       assert html_response(conn, 200) =~ "Show Candle"
#     end

#     test "renders errors when data is invalid", %{conn: conn} do
#       conn = post conn, candle_path(conn, :create), candle: @invalid_attrs
#       assert html_response(conn, 200) =~ "New Candle"
#     end
#   end

  # Private functions
  defp create_currency(_) do
    currency = Factory.insert(:currency)
    {:ok, currency: currency}
  end

  defp create_candle(%{currency: currency}) do
    candle = Factory.insert(:candle, currency: currency)
    {:ok, candle: candle}
  end
end
