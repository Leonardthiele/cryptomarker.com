defmodule Platform.Social.Schema.GithubRepo do
  @moduledoc """
  A github repository which belongs to a currency.
  """
  use Platform, :schema

  schema "github_repos" do
    field :full_name, :string
    field :stars_count, :integer
    field :forks_count, :integer
    field :watchers_count, :integer
    field :open_issues_count, :integer
    timestamps()

    belongs_to :currency, Platform.Core.Schema.Currency
  end

  @doc false
  @fields ~w(full_name)
  def changeset(%__MODULE__{} = model, attrs) do
    model
    |> cast(attrs, @fields)
    |> validate_required([:full_name])
    |> validate_format(:full_name, ~r/^([-_\w]+)\/([-_.\w]+)$/)
    |> unique_constraint(:full_name)
  end

  @doc """
  Used when we get data from the github api
  """
  @fields ~w(stars_count forks_count watchers_count open_issues_count)
  def api_changeset(%__MODULE__{} = currency, attrs) do
    currency
    |> cast(attrs, @fields)
    |> validate_required([:stars_count])
  end
end
