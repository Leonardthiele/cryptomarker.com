defmodule ExternalApi.CoinMarketCap do
  @moduledoc """
  Api wrapper for CoinMarketCap
  """

  @doc """
  Gets the latest coin stats
  https://api.coinmarketcap.com/v1/ticker
  """
  def ticker, do: api_get!("ticker/")

  # Private functions
  defp api_get!(path) when is_binary(path) do
    url = "https://api.coinmarketcap.com/v1/#{path}"

    HTTPoison.get!(url).body
    |> Poison.decode!
  end
end
