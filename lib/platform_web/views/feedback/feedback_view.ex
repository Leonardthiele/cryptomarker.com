defmodule PlatformWeb.FeedbackView do
  use PlatformWeb, :view

  def page("index.html", conn), do: %{
    title: "Feedback",
    path: feedback_path(conn, :index)
  }
end
