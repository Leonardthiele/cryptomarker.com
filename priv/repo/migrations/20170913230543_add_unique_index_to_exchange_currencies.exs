defmodule Platform.Repo.Migrations.AddUniqueIndexToExchangeCurrencies do
  use Ecto.Migration

  def change do
    create unique_index(:exchange_currencies, [:exchange_id, :currency_id])
  end
end

