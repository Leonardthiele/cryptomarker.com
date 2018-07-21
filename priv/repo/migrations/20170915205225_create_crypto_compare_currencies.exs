defmodule Platform.Repo.Migrations.CreateCryptoCompareCurrencies do
  use Ecto.Migration

  def change do
    create table(:cryptocompare_currencies) do
      add :symbol, :string, null: false, limit: 16
      add :full_snapshot, :longtext
      add :social_stats, :longtext
      timestamps()
    end
  end
end
