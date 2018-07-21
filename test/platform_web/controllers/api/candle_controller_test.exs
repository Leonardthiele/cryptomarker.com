defmodule PlatformWeb.Api.CandleControllerTest do
  use PlatformWeb.ConnCase

  setup :create_currency

  describe "#index" do
    setup :create_candle

    test "lists all currencies", %{conn: conn, currency: currency, candle: candle} do
      conn = get conn, api_candle_path(conn, :index, currency_id: currency.id)

      body = json_response(conn, 200)
      assert List.first(body) == [candle.time * 1000, 4236.75, 27.82]
    end
  end

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
