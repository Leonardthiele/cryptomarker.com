defmodule Platform.Core do
  @moduledoc """
  The Core context.
  """
  import Ecto.Query, warn: false
  import Ecto

  alias Platform.Repo
  alias Platform.Core.Schema.Currency
  alias Platform.Accounts.Schema.CurrencyRating
  alias Platform.Exchanges.Schema.ExchangeCurrency
  alias Platform.Core.CurrencyCompletenessScore
  alias Platform.Core.Schema.CurrencyLink

  ### ################################################################### ###
  ### Currency                                                            ###
  ### ################################################################### ###
  def list_currencies do
    Currency
    |> Ecto.Query.order_by([desc: :market_cap_usd])
    |> Repo.all
  end

  def list_currencies_by_name do
    Currency
    |> Ecto.Query.order_by([asc: :name])
    |> Repo.all
  end

  def list_favorite_currencies do
    Currency
    |> Ecto.Query.where(favorite: true)
    |> Repo.all
  end

  def get_currencies_avg_completeness_score do
    Currency
    |> Repo.aggregate(:avg, :completeness_score)
  end

  def get_currencies_total_market_usd do
    Currency
    |> Repo.aggregate(:sum, :market_cap_usd)
  end

  def query_currencies(params, nil) do
    query = case params["view"] do
      "penny" ->
        Currency
        |> Ecto.Query.where([q], q.price_usd > 0.8 and q.price_usd < 1.1)
      _ ->
        Currency
    end

    query
    |> Ecto.Query.order_by([desc: :market_cap_usd])
    |> Repo.all()
  end

  def query_currencies(params, user) do
    view = case params["view"] do
      "penny" ->
        Currency
        |> Ecto.Query.where([q], q.price_usd > 0.8 and q.price_usd < 1.1)
      "bittrex" ->
        exchange_currencies =
        ExchangeCurrency
        |> Ecto.Query.where(exchange_id: 2)
        |> Repo.all
        |> Enum.map(fn(ec) -> ec.currency_id end)

        Currency
        |> Ecto.Query.where([q], q.id in ^exchange_currencies)
      "bittrex_vol" ->
        exchange_currencies =
        ExchangeCurrency
        |> Ecto.Query.where(exchange_id: 2)
        |> Repo.all
        |> Enum.map(fn(ec) -> ec.currency_id end)

        Currency
        |> Ecto.Query.where([q], q.id in ^exchange_currencies)
        |> Ecto.Query.where([q], q.volume_24h_usd > 450_000.0)
      _ ->
        Currency
    end

    order =
      if params["order"] do
        if params["order_direction"] == "desc" do
          view
          |> Ecto.Query.order_by([desc: ^String.to_atom(params["order"])])
        else
          view
          |> Ecto.Query.order_by([asc: ^String.to_atom(params["order"])])
          end
      else
        view
        |> Ecto.Query.order_by([desc: :market_cap_usd])
      end

    # currency_rating =  from c in CurrencyRating, select: count("*"), group_by: c.id, where: c.user_id == ^user.id

    currency_rating =  from c in CurrencyRating, select: [:rating], where: c.user_id == ^user.id

    order
    |> Repo.all()
    |> Repo.preload(currency_ratings: currency_rating)
  end

  def update_currency_completeness_score(%Currency{} = currency) do
    currency =
      currency
      |> Repo.preload(:currency_links)
      |> Repo.preload(:twitter_accounts)
      |> Repo.preload(:reddits)
      |> Repo.preload(:github_repos)

    score = CurrencyCompletenessScore.result(currency)

    update_currency(currency, %{completeness_score: score})
  end

  def get_currency!(id) do
    Currency
    |> Repo.get!(id)
    |> Repo.preload(twitter_accounts: :twitter_statuses)
    |> Repo.preload(:currency_links)
    |> Repo.preload(:reddits)
    |> Repo.preload(:github_repos)
    |> Repo.preload([exchange_currencies: :exchange])
    |> Repo.preload([:asset_parent])
  end

  def create_currency(attrs \\ %{}) do
    with {:ok, currency} <- %Currency{} |> Currency.changeset(attrs) |> Repo.insert(),
      {:ok, currency_with_logo} <- currency |> Currency.file_changeset(attrs) |> Repo.update()
    do
      {:ok, currency_with_logo}
    else
      {:error, changeset} -> {:error, changeset}
    end
  end

  def update_currency(%Currency{} = currency, attrs) do
    with {:ok, currency} <- currency |> Currency.changeset(attrs) |> Repo.update(),
         {:ok, currency_with_logo} <- currency |> Currency.file_changeset(attrs) |> Repo.update()
    do
      {:ok, currency_with_logo}
    else
      {:error, changeset} -> {:error, changeset}
    end
  end

  def delete_currency(%Currency{} = currency) do
    Repo.delete(currency)
  end

  def change_currency(%Currency{} = currency) do
    Currency.changeset(currency, %{})
  end

  ### ################################################################### ###
  ### Candle                                                              ###
  ### ################################################################### ###
  def list_candles(%Currency{} = currency) do
    currency
    |> Ecto.assoc(:candles)
    |> Ecto.Query.order_by([asc: :time])
    |> Repo.all
  end

  def paginate_candels(currency, params) do
    currency
    |> assoc(:candles)
    |> Ecto.Query.order_by([desc: :time])
    |> Repo.paginate(params)
  end

  def lastest_candle_timestamp(currency) do
    candles =
      currency
      |> assoc(:candles)

    Repo.one(from candle in candles, select: max(candle.time))
  end

  ### ################################################################### ###
  ### CurrencyLink                                                        ###
  ### ################################################################### ###
  def get_currency_link!(currency, id) do
    currency
    |> assoc(:currency_links)
    |> Repo.get!(id)
  end

  def create_currency_link(currency, attrs \\ %{}) do
    %CurrencyLink{currency: currency}
    |> CurrencyLink.changeset(attrs)
    |> Repo.insert()
  end

  def update_currency_link(%CurrencyLink{} = currency_link, attrs) do
    currency_link
    |> CurrencyLink.changeset(attrs)
    |> Repo.update()
  end

  def delete_currency_link(%CurrencyLink{} = currency_link) do
    Repo.delete(currency_link)
  end

  def change_currency_link(currency, %CurrencyLink{} = currency_link) do
    CurrencyLink.changeset(currency_link, %{currency: currency})
  end
end
