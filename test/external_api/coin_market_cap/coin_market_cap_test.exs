defmodule ExternalApi.CoinMarketCapTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias ExternalApi.CoinMarketCap

  describe "#ticker" do
    test "gets the currency list" do
      use_cassette "coin_market_cap#ticker" do
        ticker = CoinMarketCap.ticker()
        assert ticker |> Enum.any?(fn(currency) -> currency["name"] == "Bitcoin" end)
      end
    end
  end
end
