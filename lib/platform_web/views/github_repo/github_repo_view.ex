defmodule PlatformWeb.GithubRepoView do
  alias PlatformWeb.CurrencyView
  use PlatformWeb, :view

  def page("new.html", conn), do: %{
    parent: CurrencyView.page("show.html", conn),
    title: "New github repo"
  }
end
