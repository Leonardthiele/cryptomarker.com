defmodule Platform.Exchanges.ExchangeCurrencyUpdater do
  @moduledoc """
  This is used by exchange apis. You give it and exchange and the
  current active currencies as symbols.
  """

  alias Platform.Repo
  alias Platform.Exchanges.Schema.ExchangeCurrency
  alias Platform.Exchanges.Schema.Exchange
  alias Platform.Core.Schema.Currency
  require Ecto.Query

  @doc """
  Pass an exchange an a list of active symbols.

      update(exchange, ["BTC", "NEO"])
  """
  def update(%Exchange{} = exchange, currency_symbols) when is_list(currency_symbols) do
    Enum.each currency_symbols, fn(symbol) ->
      if currency = get_currency_by_symbol(symbol) do
        find_or_create_exchange_currency(exchange, currency)
      end
    end
  end

  # Private methods
  defp find_or_create_exchange_currency(%Exchange{id: exchange_id}, %Currency{id: currency_id}) do
    if !Repo.get_by(ExchangeCurrency, exchange_id: exchange_id, currency_id: currency_id) do
      %ExchangeCurrency{exchange_id: exchange_id, currency_id: currency_id}
      |> ExchangeCurrency.changeset(%{active: true})
      |> Repo.insert!
    end
  end

  defp get_currency_by_symbol(symbol) do
    Currency
    |> Repo.get_by(symbol: symbol)
  end
end
