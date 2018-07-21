defmodule PlatformWeb.Api.CurrencyControllerTest do
  use PlatformWeb.ConnCase

  describe "#index" do
    setup :create_currency

    test "lists all currencies", %{conn: conn, currency: currency} do
      conn = get conn, api_currency_path(conn, :index)

      assert json_response(conn, 200) == [
        %{"id" => currency.id,
          "name" => "Bitcoin (BTC)",
          "logo" => "",
        }
      ]
    end
  end

  # Private functions
  defp create_currency(_) do
    currency = Factory.insert(:currency)
    {:ok, currency: currency}
  end
end
