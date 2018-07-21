defmodule Platform.Accounts.Schema.CurrencyRating do
  @moduledoc """
  This is the connection between users and currencies.
  Defines favorites if rating is greater than 0.
  A user can give an additional comment to justify the rating.
  """
  use Platform, :schema

  schema "currency_ratings" do
    field :rating, :integer, default: 0
    field :comment, :string
    timestamps()

    belongs_to :currency, Platform.Core.Schema.Currency
    belongs_to :user, Platform.Accounts.Schema.User
  end

  @doc false
  def changeset(%__MODULE__{} = model, attrs) do
    model
    |> cast(attrs, [:rating, :comment])
    |> validate_required([:rating])
  end
end
