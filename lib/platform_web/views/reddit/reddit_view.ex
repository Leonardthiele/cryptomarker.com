defmodule PlatformWeb.RedditView do
  alias PlatformWeb.CurrencyView
  use PlatformWeb, :view

  def page("new.html", conn), do: %{
    parent: CurrencyView.page("show.html", conn),
    title: "New reddit"
  }
end
