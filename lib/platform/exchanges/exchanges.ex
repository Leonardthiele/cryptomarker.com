defmodule Platform.Exchanges do
  @moduledoc """
  The Exchanges context.
  """
  import Ecto.Query, warn: false

  alias Platform.Repo
  alias Platform.Exchanges.Schema.Exchange
  alias Platform.Exchanges.Schema.ExchangeCurrency

  ### ################################################################### ###
  ### Exchange                                                            ###
  ### ################################################################### ###
  def list_exchanges do
    query = from e in Exchange,
      left_join: c in assoc(e, :exchange_currencies),
      select: %{e | exchange_currencies: count(c.id)},
      group_by: e.id

    query
    |> Repo.all
  end

  def get_exchange!(id) do
    Exchange
    |> Repo.get!(id)
    |> Repo.preload(exchange_currencies: [:currency])
  end

  def create_exchange(attrs \\ %{}) do
    with {:ok, exchange} <- %Exchange{} |> Exchange.changeset(attrs) |> Repo.insert(),
         {:ok, exchange_with_logo} <- exchange |> Exchange.file_changeset(attrs) |> Repo.update()
    do
      {:ok, exchange_with_logo}
    else
      {:error, changeset} -> {:error, changeset}
    end
  end

  def update_exchange(%Exchange{} = exchange, attrs) do
    with {:ok, exchange} <- exchange |> Exchange.changeset(attrs) |> Repo.update(),
         {:ok, exchange_with_logo} <- exchange |> Exchange.file_changeset(attrs) |> Repo.update()
    do
      {:ok, exchange_with_logo}
    else
      {:error, changeset} -> {:error, changeset}
    end
end

  def delete_exchange(%Exchange{} = exchange) do
    Repo.delete(exchange)
  end

  def change_exchange(%Exchange{} = exchange) do
    Exchange.changeset(exchange, %{})
  end

  ### ################################################################### ###
  ### ExchangeCurrency                                                    ###
  ### ################################################################### ###
  def get_exchange_currency!(%Exchange{} = exchange, id) do
    exchange
    |> Ecto.assoc(:exchange_currencies)
    |> Repo.get!(id)
    |> Repo.preload(:currency)
  end

  def create_exchange_currency(%Exchange{} = exchange, attrs \\ %{}) do
    %ExchangeCurrency{exchange: exchange}
    |> ExchangeCurrency.changeset(attrs)
    |> Repo.insert()
  end

  def update_exchange_currency(%Exchange{} = _exchange, %ExchangeCurrency{} = exchange_currency, attrs) do
    exchange_currency
    |> ExchangeCurrency.changeset(attrs)
    |> Repo.update()
  end

  def delete_exchange_currency(%Exchange{} = _exchange, %ExchangeCurrency{} = exchange_currency) do
    Repo.delete(exchange_currency)
  end

  def change_exchange_currency(%Exchange{} = exchange, %ExchangeCurrency{} = exchange_currency) do
    ExchangeCurrency.changeset(exchange_currency, %{exchange: exchange})
  end
end
