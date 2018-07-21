defmodule Platform.Repo.Migrations.AddImportedRedditToCurrencies do
  use Ecto.Migration

  def change do
    alter table(:currencies) do
      add :imported_reddit, :boolean, null: false, default: false
    end
  end
end
