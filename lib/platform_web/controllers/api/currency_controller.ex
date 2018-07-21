defmodule PlatformWeb.Api.CurrencyController do
  use PlatformWeb, :controller

  alias Platform.Core

  def index(conn, _) do
    currencies = Core.list_currencies
    render conn, "index.json", currencies: currencies
  end
end
