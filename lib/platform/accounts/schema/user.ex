defmodule Platform.Accounts.Schema.User do
  @moduledoc """
  The user schema. Contains personal data of a user, the role and
  authentication details.
  """
  use Platform, :schema

  schema "users" do
    field :name, :string
    field :email, :string
    field :github_uid, :string
    field :admin, :boolean, default: false
    field :developer, :boolean, default: false
    field :moderator, :boolean, default: false
    field :public_profile, :boolean, default: true
    timestamps()

    has_many :currency_ratings, Platform.Accounts.Schema.CurrencyRating, on_delete: :delete_all
  end

  @doc false
  def changeset(%__MODULE__{} = model, attrs) do
    model
    |> cast(attrs, [:email, :name, :github_uid])
    |> validate_required([:email, :name, :github_uid])
    |> unique_constraint(:email)
  end
end
