defmodule Platform.Social.Schema.TwitterAccount do
  @moduledoc """
  A twitter account belongs to a currency. Can exists multiple times if
  e.g. a developer works for multiple projects.
  """
  use Platform, :schema

  schema "twitter_accounts" do
    field :twitter_user_id, :integer
    field :screen_name, :string
    field :name, :string
    field :image_url, :string
    field :followers_count, :integer
    field :tweets_count, :integer
    field :following, :boolean, default: false
    timestamps()

    belongs_to :currency, Platform.Core.Schema.Currency
    has_many :twitter_statuses, Platform.Social.Schema.TwitterStatus, references: :twitter_user_id, foreign_key: :twitter_user_id
  end

  @doc false
  @fields [:twitter_user_id, :name, :screen_name, :image_url, :followers_count, :tweets_count, :following]
  def changeset(%__MODULE__{} = model, attrs) do
    model
    |> cast(attrs, @fields)
    |> validate_required([:screen_name, :twitter_user_id])
    |> validate_format(:screen_name, ~r/^@?(\w){1,15}$/)
    |> unique_constraint(:screen_name, name: :twitter_accounts_currency_id_screen_name_index)
    |> remove_at_sign_from_name(:screen_name)
  end

  defp remove_at_sign_from_name(%Ecto.Changeset{} = changeset, field) do
    name = get_field(changeset, field)

    if name && String.contains?(name, "@") do
      changeset
      |> put_change(field, String.replace(name, "@", ""))
    else
      changeset
    end
  end
end
