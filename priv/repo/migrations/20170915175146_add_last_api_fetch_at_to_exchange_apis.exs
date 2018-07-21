defmodule Platform.Repo.Migrations.AddLastApiFetchAtToExchangeApis do
  use Ecto.Migration

  def change do
    alter table(:exchange_apis) do
      add :last_api_fetch_at, :utc_datetime
    end
  end
end
