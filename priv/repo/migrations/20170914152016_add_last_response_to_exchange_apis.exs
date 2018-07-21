defmodule Platform.Repo.Migrations.AddLastResponseToExchangeApis do
  use Ecto.Migration

  def change do
    alter table(:exchange_apis) do
      add :last_response, :text
    end
  end
end
