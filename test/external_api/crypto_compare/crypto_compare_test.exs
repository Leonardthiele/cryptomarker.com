defmodule ExternalApi.CryptoCompareTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias ExternalApi.CryptoCompare

  describe "#coinlist" do
    test "get the coinlist" do
      use_cassette "crypto_compare#coinlist" do
        coinlist = CryptoCompare.coinlist()
        assert coinlist |> Map.has_key?("BTC")
      end
    end

    test "get one symbol from the coinlist" do
      use_cassette "crypto_compare#coinlist" do
        symbol = CryptoCompare.coinlist("BTC")
        assert symbol["CoinName"] == "Bitcoin"
      end
    end
  end

  describe "#coinlist_symbols" do
    test "get the symbols from the coinlist" do
      use_cassette "crypto_compare#coinlist" do
        symbols = CryptoCompare.coinlist_symbols()
        assert symbols |> Enum.member?("BTC")
      end
    end
  end

end
