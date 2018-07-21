defmodule Platform.Social.TwitterStatusApi do
  @moduledoc """
  Poll the twitter timetime of cryptomarker_ for the lastest tweets.
  Add or updates the twitter status with likes and retweets.
  """
  alias Platform.Repo
  alias Platform.Social.Schema.TwitterStatus
  require Ecto.Query
  require Logger

  @doc """
  Get the latest tweets from the timeline of our account cryptomarker_.
  This is the only way to get updates of multiple accounts.
  """
  def update_from_home_timeline(limit \\ 800) do
    timeline = ExTwitter.home_timeline(count: limit, tweet_mode: "extended")

    Enum.map timeline, fn(status) ->
      update_twitter_status(status)
    end
  end

  @doc """
  Get the latest tweets from a specific twitter account.
  Used to fetch historical status updates when we add an account.
  """
  def update_user(id) when is_integer(id) do
    timeline = ExTwitter.user_timeline(count: 100, user_id: id, tweet_mode: "extended")

    Enum.map timeline, fn(status) ->
      update_twitter_status(status)
    end
  end

  # Private methods
  defp update_twitter_status(%ExTwitter.Model.Tweet{} = status) do
    changes = %{
      twitter_user_id: status.user.id,
      screen_name: status.user.screen_name,
      favorites_count: status.favorite_count,
      retweets_count: status.retweet_count,
      text: status.text || status.full_text,
      media_url_https: get_media_url(status),
      lang: status.lang
    }

    twitter_status = case Repo.get(TwitterStatus, status.id) do
      nil  -> %TwitterStatus{id: status.id, inserted_at: parse_twitter_timestamp(status.created_at)} # Post not found, we build one
      feed -> feed          # Post exists, let's use it
    end

    twitter_status
    |> TwitterStatus.changeset(changes)
    |> Repo.insert_or_update!
  end

  def get_media_url(%{entities: %{media: media}}) do
    first_media = media |> List.first
    first_media.media_url_https
  end
  def get_media_url(_), do: nil

  @doc """
  Transforms the unusual twitter timestamp to sth. we can parse

  iex> TwitterStatusApi.parse_twitter_timestamp("Tue Sep 19 22:39:01 +0000 2017")
  #DateTime<2017-09-19 22:39:01Z>
  """
  def parse_twitter_timestamp(timestamp) when is_binary(timestamp) do
    [dow, mon, day, time, zone, year] = String.split(timestamp, " ")
    rfc2822 = Enum.join(["#{dow},", day, mon, year, time, zone], " ")
    {:ok, datetime} = Calendar.DateTime.Parse.rfc2822_utc(rfc2822)
    datetime
  end
end
