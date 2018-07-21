defmodule PlatformWeb.Developer.DashboardView do
  use PlatformWeb, :view

  # Page Configuration
  def page("show.html", _conn), do: %{
    title: "Dashboard"
  }
end
