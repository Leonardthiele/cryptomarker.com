defmodule PlatformWeb.ExchangeCurrencyView do
  alias PlatformWeb.ExchangeView
  use PlatformWeb, :view

  def page("new.html", conn), do: %{
    parent: ExchangeView.page("show.html", conn),
    title: "New exchange currency"
  }
  def page("edit.html", conn), do: %{
    parent: ExchangeView.page("show.html", conn),
    title: "Edit exchange currency"
  }
end
