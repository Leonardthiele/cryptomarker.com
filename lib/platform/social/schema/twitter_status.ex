defmodule Platform.Social.Schema.TwitterStatus do
  @moduledoc """
  This is one tweet from a user. There is an updater which
  polls all the latest tweet from our own twitter account.
  """
  use Platform, :schema

  @timestamps_opts [type: :utc_datetime, usec: false]
  schema "twitter_statuses" do
    field :twitter_user_id, :integer
    field :screen_name, :string
    field :text, :string
    field :media_url_https, :string
    field :lang, :string
    field :unimportant, :boolean, default: false
    field :rating, :integer, default: 0
    field :retweets_count, :integer, default: 0
    field :favorites_count, :integer, default: 0
    field :replies_count, :integer, default: 0 # not available via api
    timestamps()

    has_many :twitter_accounts, Platform.Social.Schema.TwitterAccount, references: :twitter_user_id, foreign_key: :twitter_user_id
  end

  @doc false
  @fields [:twitter_user_id, :unimportant, :rating, :screen_name, :text, :media_url_https, :lang, :retweets_count, :favorites_count, :replies_count]
  def changeset(%__MODULE__{} = model, attrs) do
    model
    |> cast(attrs, @fields)
    |> validate_required([:twitter_user_id, :unimportant, :rating, :screen_name, :text, :lang, :retweets_count, :favorites_count])
  end
end
