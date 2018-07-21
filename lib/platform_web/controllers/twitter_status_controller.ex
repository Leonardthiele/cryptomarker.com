defmodule PlatformWeb.TwitterStatusController do
  use PlatformWeb, :controller

  alias Platform.Social

  def index(conn, params) do
    top_twitter_statuses = Social.top_twitter_statuses()
    page = Social.paginate_twitter_statuses(params)

    render(conn, "index.html", page: page, last_twitter_statuses: page.entries, top_twitter_statuses: top_twitter_statuses)
  end

  def show(conn, %{"id" => id}) do
    twitter_status = Social.get_twitter_status!(id)

    render(conn, "show.html", twitter_status: twitter_status)
  end

  def update(conn, %{"id" => id, "rating" => rating}) do
    twitter_status = Social.get_twitter_status!(id)

    Social.update_twitter_status(twitter_status, %{rating: rating})

    conn
    |> put_flash(:info, "Favorite status changed.")
    |> redirect(to: twitter_status_path(conn, :show, twitter_status))
  end

  def update(conn, %{"id" => id, "toggle" => "unimportant"}) do
    twitter_status = Social.get_twitter_status!(id)

    Social.toggle_twitter_status_unimportant(twitter_status)

    conn
    |> put_flash(:info, "Unimportant status changed.")
    |> redirect(to: twitter_status_path(conn, :show, twitter_status))
  end
end
