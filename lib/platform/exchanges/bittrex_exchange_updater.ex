defmodule Platform.Exchanges.BittrexExchangeUpdater do
  @moduledoc """
  This is used by exchange apis. You give it and exchange and the
  current active currencies as symbols.
  """
  alias Platform.Repo
  alias Platform.Exchanges.Schema.ExchangeCurrency
  alias Platform.Exchanges.Schema.Exchange
  alias Platform.Core.Schema.Currency
  require Ecto.Query

  def clean_not_bittrex do
    active_symbols = get_active_bittrex_symbols()

    currencies =
      Currency
      |> Ecto.Query.where([c], not c.symbol in ^active_symbols)
      |> Repo.all()

    Enum.each currencies, fn currency ->
      Repo.delete(currency)
    end
  end

  def get_active_bittrex_symbols do
    symbols = CryptoExchanges.BittrexAdapter.get_currencies
    |> Enum.filter(&(&1.active))
    |> Enum.map(&(&1.symbol))
    symbols ++ ["BCH"] -- ["BCC"]
  end
end
