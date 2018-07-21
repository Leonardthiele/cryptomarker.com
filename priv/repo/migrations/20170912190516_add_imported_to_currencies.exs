defmodule Platform.Repo.Migrations.AddImportedToCurrencies do
  use Ecto.Migration

  def change do
    alter table(:currencies) do
      add :imported, :boolean, null: false, default: false
    end
  end
end
