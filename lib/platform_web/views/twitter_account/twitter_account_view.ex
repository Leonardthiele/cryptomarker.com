defmodule PlatformWeb.TwitterAccountView do
  alias PlatformWeb.CurrencyView
  alias PlatformWeb.TwitterStatusView
  use PlatformWeb, :view

  def page("index.html", conn), do: %{
    parent: CurrencyView.page("show.html", conn),
    title: "Twitter accounts",
    path: currency_twitter_account_path(conn, :index, conn.assigns.currency)
  }
  def page("show.html", conn), do: %{
    parent: page("index.html", conn),
    title: conn.assigns.twitter_account.name
  }
  def page("new.html", conn), do: %{
    parent: page("index.html", conn),
    title: "New twitter account"
  }
end
