defmodule Platform.Core.CurrencyUpdaterCmc do
  @moduledoc """
  Fetches the currency market data from CoinMarketCap.
  This is done one a minute (see Quantum Config).
  Includes new currencies, prices, price changes, volume, market cap.
  """
  alias Platform.Repo
  alias Platform.Core.Schema.Currency
  alias ExternalApi.CoinMarketCap
  require Logger

  def update_all do
    Logger.info("Updating currencies from Coin Market Cap")
    cmc_currencies = CoinMarketCap.ticker()

    Enum.each cmc_currencies, fn(cmc_currency) ->
      update(cmc_currency)
    end
  end

  def update(cmc_currency) do
    changes = %{
      symbol: cmc_currency["symbol"],
      name: cmc_currency["name"],
      slug: cmc_currency["id"],
      market_cap_usd: cmc_currency["market_cap_usd"]  || 0,
      volume_24h_usd: cmc_currency["24h_volume_usd"] || 0,
      available_supply: cmc_currency["available_supply"]  || 0,
      total_supply: cmc_currency["total_supply"]  || 0,
      percent_change_1h: cmc_currency["percent_change_1h"],
      percent_change_24h: cmc_currency["percent_change_24h"],
      price_btc: cmc_currency["price_btc"],
      price_usd: cmc_currency["price_usd"]
    }

    if currency = Repo.get_by(Currency, slug: cmc_currency["id"]) do
      currency
      |> Currency.changeset(changes)
      |> Repo.update
    end
  end
end
