defmodule PlatformWeb.Api.CandleController do
  use PlatformWeb, :controller

  alias Platform.Core

  def index(conn, %{"currency_id" => currency_id}) do
    currency = Core.get_currency!(currency_id)
    candles = currency |> Core.list_candles

    render conn, "index.json", candles: candles
  end
end
