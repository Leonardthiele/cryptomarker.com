defmodule Platform.Social.Schema.Reddit do
  @moduledoc """
  A subreddit which belongs to a currency.
  """
  use Platform, :schema

  schema "reddits" do
    field :name, :string
    field :subscribers_count, :integer
    field :active_users_count, :integer
    field :posts_per_hour, :integer
    field :posts_per_day, :integer
    field :comments_per_hour, :integer
    field :comments_per_day, :integer
    timestamps()

    belongs_to :currency, Platform.Core.Schema.Currency
  end

  @doc false
  @fields [:name]
  def changeset(%__MODULE__{} = model, attrs) do
    model
    |> cast(attrs, @fields)
    |> validate_required([:name])
  end

  @doc """
  Used when we get data from the reddit api
  """
  @fields ~w(subscribers_count)
  def api_changeset(%__MODULE__{} = currency, attrs) do
    currency
    |> cast(attrs, @fields)
    |> validate_required([:subscribers_count])
  end
end
