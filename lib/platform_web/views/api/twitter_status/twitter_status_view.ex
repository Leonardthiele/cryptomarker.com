defmodule PlatformWeb.Api.TwitterStatusView do
  use PlatformWeb, :view

  def render("index.json", %{twitter_statuses: twitter_statuses}) do
    Enum.map twitter_statuses, &twitter_status_json(&1)
  end

  def twitter_status_json(twitter_status) do
    %{
      x: DateTime.to_unix(twitter_status.inserted_at) * 1000,
      title: "T",
      text: twitter_status.text,
      id: Integer.to_string(twitter_status.id),
      color: case twitter_status.rating do
        -1 -> "#ff0000"
        1  -> "#00ff00"
        _  -> "#ccc"
      end
    }
  end
end
