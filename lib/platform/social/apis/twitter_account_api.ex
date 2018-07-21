defmodule Platform.Social.TwitterAccountApi do
  @moduledoc """
  Fetches the all the current stats from a twitter account.
  E.g. current followers count, tweets count
  """
  alias Platform.Repo
  alias Platform.Social.Schema.TwitterAccount
  require Ecto.Query
  require Logger

  def update_all do
    two_hours_ago = Calendar.DateTime.add!(Calendar.DateTime.now_utc, -2 * 3600)

    twitter_accounts =
      TwitterAccount
      |> Ecto.Query.where([q], q.updated_at < ^two_hours_ago)
      |> Ecto.Query.order_by([asc: :updated_at])
      |> Ecto.Query.limit(50)
      |> Repo.all()

    twitter_screen_names = twitter_accounts |> Enum.map(&(&1.screen_name))

    twitter_users = ExTwitter.user_lookup(twitter_screen_names)

    Enum.each twitter_accounts, fn(twitter_account) ->
      twitter_user = twitter_users |> Enum.find(&(String.downcase(&1.screen_name) == String.downcase(twitter_account.screen_name)))
      if twitter_user do
        update_twitter_account(twitter_account, twitter_user)
        if !twitter_user.following && !twitter_user.protected do
          ExTwitter.follow(twitter_user.id)
        end
      end
    end
  end

  def update(%TwitterAccount{screen_name: screen_name} = twitter_account) do
    twitter_user = ExTwitter.user(twitter_account.twitter_user_id || screen_name)
    update_twitter_account(twitter_account, twitter_user)
  end

  # Private methods
  defp update_twitter_account(%TwitterAccount{} = twitter_account, %ExTwitter.Model.User{} = twitter_user) do
    changes = %{
      twitter_user_id: twitter_user.id,
      image_url: twitter_user.profile_image_url_https,
      name: twitter_user.name,
      followers_count: twitter_user.followers_count,
      tweets_count: twitter_user.statuses_count,
      following: twitter_user.following
    }

    twitter_account
    |> TwitterAccount.changeset(changes)
    |> Repo.update()
  end
end
