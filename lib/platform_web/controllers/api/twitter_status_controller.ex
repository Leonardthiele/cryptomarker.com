defmodule PlatformWeb.Api.TwitterStatusController do
  use PlatformWeb, :controller

  alias Platform.Core
  alias Platform.Social

  def index(conn, %{"currency_id" => currency_id}) do
    currency = Core.get_currency!(currency_id)
    twitter_statuses = currency |> Social.list_twitter_statuses()

    render conn, "index.json", twitter_statuses: twitter_statuses
  end
end
