defmodule PlatformWeb.TwitterStatusView do
  use PlatformWeb, :view

  def page("index.html", _conn), do: %{
    title: "Twitter Stream"
  }
  def page("show.html", _conn), do: %{
    title: "Twitter Stream"
  }
end
