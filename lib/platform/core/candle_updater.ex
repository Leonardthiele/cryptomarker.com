defmodule Platform.Core.CandleUpdater do
  @moduledoc """
  Fetches ohcl data for a currency
  """
  alias Platform.Repo
  alias ExternalApi.CryptoCompare
  alias Platform.Core
  alias Platform.Core.Schema.{Currency, Candle}

  def update_all(%Currency{} = currency) do
    latest_ts = Core.lastest_candle_timestamp(currency)

    result = CryptoCompare.histominute(currency.symbol, latest_ts)

    Enum.each result, fn(currency_data) ->
      update(currency, currency_data)
    end
  end

  def update(currency, %{"time" => time, "open" => open, "high" => high, "close" => close, "low" => low, "volumefrom" => volume_from, "volumeto" => volume_to}) do
    changes = %{
      currency_symbol: currency.symbol, currency_to: "USD",
      time: time,
      open: open, high: high, close: close, low: low,
      volume_from: volume_from, volume_to: volume_to,
    }

    candle = case Repo.get_by(Candle, currency_symbol: currency.symbol, currency_to: "USD", time: time) do
      nil  -> %Candle{currency_id: currency.id, currency_symbol: currency.symbol}
      candle -> candle
    end

    candle
    |> Candle.changeset(changes)
    |> Repo.insert_or_update
  end
end
