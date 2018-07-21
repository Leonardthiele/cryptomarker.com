defmodule Platform.Core.Schema.Currency do
  @moduledoc """
  The central schema for currencies.
  """
  use Platform, :schema
  use Arc.Ecto.Schema

  schema "currencies" do
    field :symbol, :string
    field :name, :string
    field :logo, Platform.Core.CurrencyLogoUploader.Type
    field :slug, :string
    field :market_cap_usd, :float
    field :volume_24h_usd, :float
    field :available_supply, :float
    field :total_supply, :float
    field :percent_change_1h, :float
    field :percent_change_24h, :float
    field :price_usd, :float
    field :price_btc, :float
    field :markets_count, :integer, default: 0
    field :favorite, :boolean, default: false
    field :no_twitter, :boolean, default: false
    field :short_summary, :string
    field :description, :string
    field :completeness_score, :float
    field :starts_on, :date
    field :bittrex_market_name, :string
    field :imported, :boolean # temp variable for imports
    field :imported_reddit, :boolean # temp variable for imports
    field :imported_starts_on, :boolean # temp variable for imports
    timestamps()

    belongs_to :asset_parent, Platform.Core.Schema.Currency
    has_many :candles,  Platform.Core.Schema.Candle, on_delete: :delete_all
    has_many :twitter_accounts, Platform.Social.Schema.TwitterAccount, on_delete: :delete_all
    has_many :reddits, Platform.Social.Schema.Reddit, on_delete: :delete_all
    has_many :github_repos, Platform.Social.Schema.GithubRepo, on_delete: :delete_all
    has_many :currency_links,  Platform.Core.Schema.CurrencyLink, on_delete: :delete_all
    has_many :currency_ratings, Platform.Accounts.Schema.CurrencyRating, on_delete: :delete_all
    has_many :exchange_currencies, Platform.Exchanges.Schema.ExchangeCurrency, on_delete: :delete_all
  end

  @doc false
  @fields ~w(bittrex_market_name no_twitter slug symbol name completeness_score markets_count price_usd price_btc volume_24h_usd market_cap_usd available_supply total_supply percent_change_1h percent_change_24h short_summary description asset_parent_id starts_on)
  def changeset(%__MODULE__{} = model, attrs) do
    model
    |> cast(attrs, @fields)
    |> unique_constraint(:symbol)
    |> unique_constraint(:slug)
    |> validate_required([:symbol, :name, :slug])
  end

  @file_fields ~w(logo)
  def file_changeset(%__MODULE__{} = currency, params \\ %{}) do
    currency
    |> cast_attachments(params, @file_fields)
  end
end
