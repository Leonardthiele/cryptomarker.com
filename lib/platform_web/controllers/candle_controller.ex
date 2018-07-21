defmodule PlatformWeb.CandleController do
  use PlatformWeb, :controller

  alias Platform.Core
  alias Platform.Core.Schema.Candle
  alias Platform.Core.CandleUpdater

  def index(conn, %{"currency_id" => currency_id} = params) do
    Candle |> authorize_action!(conn)
    currency = Core.get_currency!(currency_id)

    page = Core.paginate_candels(currency, params)
    render(conn, "index.html", currency: currency, candles: page.entries)
  end

  def create(conn, %{"currency_id" => currency_id}) do
    Candle |> authorize_action!(conn)

    currency = Core.get_currency!(currency_id)
    CandleUpdater.update_all(currency)

    conn
    |> put_flash(:info, "Candle data fetched")
    |> redirect(to: currency_path(conn, :show, currency))
  end
end
