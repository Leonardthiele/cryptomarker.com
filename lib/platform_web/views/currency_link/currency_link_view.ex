defmodule PlatformWeb.CurrencyLinkView do
  alias Platform.Core.Schema.CurrencyLink
  alias PlatformWeb.CurrencyView
  use PlatformWeb, :view

  def page("new.html", conn), do: %{
    parent: CurrencyView.page("show.html", conn),
    title: "New link"
  }
  def page("edit.html", conn), do: %{
    parent: CurrencyView.page("show.html", conn),
    title: "Edit link"
  }
end
