defmodule Platform.Repo.Migrations.AddBittrexMarketnameToCurrencies do
  use Ecto.Migration

  def change do
    alter table(:currencies) do
      add :bittrex_market_name, :string
    end
  end
end
