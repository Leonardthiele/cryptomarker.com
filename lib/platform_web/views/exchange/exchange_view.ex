defmodule PlatformWeb.ExchangeView do
  alias Platform.Exchanges.ExchangeLogoUploader
  alias Platform.Core.CurrencyLogoUploader
  use PlatformWeb, :view

  def page("index.html", conn), do: %{
    title: "Exchanges",
    path: exchange_path(conn, :index)
  }
  def page("new.html", conn), do: %{
    parent: page("index.html", conn),
    title: "New exchange"
  }
  def page("show.html", conn), do: %{
    parent: page("index.html", conn),
    title: "#{conn.assigns.exchange.name}",
    path: exchange_path(conn, :show, conn.assigns.exchange)
  }
  def page("edit.html", conn), do: %{
    parent: page("show.html", conn),
    title: "Edit exchange",
    path: exchange_path(conn, :edit, conn.assigns.exchange)
  }
end
