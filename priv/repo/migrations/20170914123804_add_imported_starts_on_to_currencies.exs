defmodule Platform.Repo.Migrations.AddImportedStartsOnToCurrencies do
  use Ecto.Migration

  def change do
    alter table(:currencies) do
      add :imported_starts_on, :boolean, null: false, default: false
    end
  end
end
