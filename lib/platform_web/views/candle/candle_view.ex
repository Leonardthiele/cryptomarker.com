defmodule PlatformWeb.CandleView do
  alias PlatformWeb.CurrencyView
  use PlatformWeb, :view

  def page("index.html", conn), do: %{
    parent: CurrencyView.page("show.html", conn),
    title: "Candles"
  }
end
