defmodule Platform.Repo.Migrations.AddCurrenciesUrlToExchangeApis do
  use Ecto.Migration

  def change do
    alter table(:exchange_apis) do
      add :currencies_url, :string
    end
  end
end

