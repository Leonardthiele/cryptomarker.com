defmodule PlatformWeb.Api.CandleView do
  use PlatformWeb, :view

  def render("index.json", %{candles: candles}) do
    Enum.map candles, &candle_json(&1)
  end

  def candle_json(%{time: time, close: close, volume_from: volume_from}) do
    [time * 1000, close, volume_from]
  end
end
