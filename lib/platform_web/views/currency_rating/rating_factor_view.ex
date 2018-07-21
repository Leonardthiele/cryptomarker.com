defmodule PlatformWeb.CurrencyRatingView do
  use PlatformWeb, :view

  def page("index.html", conn), do: %{
    title: "Currency ratings",
    path: user_currency_rating_path(conn, :index, conn.assigns.user)
  }
end
