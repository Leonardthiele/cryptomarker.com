defmodule Platform.Social.RedditApi do
  @moduledoc """
  Fetches the all the latest stats from a Reddit.
  Uses the Reddit Api.
  """
  require Ecto.Query
  require Logger

  alias Platform.Repo
  alias Platform.Social.Schema.Reddit

  def update_all do
    Logger.info("Updating Reddits")

    two_hours_ago = Calendar.DateTime.add!(Calendar.DateTime.now_utc, -2 * 3600)

    reddits =
      Reddit
      |> Ecto.Query.order_by([asc: :updated_at])
      |> Ecto.Query.where([q], q.updated_at < ^two_hours_ago)
      |> Ecto.Query.limit(3)
      |> Repo.all()

    Enum.each reddits, &update(&1)
  end

  def update(%Reddit{name: name} = reddit) do
    result = get_reddit(name)

    changes = %{
      subscribers_count: result["subscribers"],
    }

    reddit
    |> Reddit.api_changeset(changes)
    |> Repo.update()
  end

  # Private functions
  defp get_reddit(reddit) do
    HTTPoison.get!("https://www.reddit.com/r/#{reddit}/about.json").body
    |> Poison.decode!
  end
end
