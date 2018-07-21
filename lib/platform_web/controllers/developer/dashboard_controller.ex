defmodule PlatformWeb.Developer.DashboardController do
  use PlatformWeb, :controller
  require Ecto.Query

  alias Platform.Core

  def show(conn, _params) do
    render conn, "show.html"
  end

  def update(conn, %{"target" => "completeness_scores"}) do
    currencies = Core.list_currencies()

    Enum.each currencies, fn(currency) ->
      Core.update_currency_completeness_score(currency)
    end

    conn
    |> put_flash(:info, "Scores updated successfully.")
    |> redirect(to: developer_dashboard_path(conn, :show))
  end
  def update(conn, %{"target" => "clean_not_bittrex"}) do
    Platform.Exchanges.BittrexExchangeUpdater.clean_not_bittrex()

    conn
    |> put_flash(:info, "Currencies not in Bittrex purged.")
    |> redirect(to: developer_dashboard_path(conn, :show))
  end
end
