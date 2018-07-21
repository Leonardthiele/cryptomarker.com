defmodule Platform.Repo.Migrations.MigrateBittrexMarkets do
  use Ecto.Migration

  alias Platform.Core

  def change do
    currencies = Core.list_currencies()

    Enum.each(currencies, &update_currency(&1))
  end

  defp update_currency(currency) do
    Core.update_currency(currency, %{bittrex_market_name: "BTC-#{currency.symbol}"})
  end
end
