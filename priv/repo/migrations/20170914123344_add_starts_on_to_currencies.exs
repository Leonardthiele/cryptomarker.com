defmodule Platform.Repo.Migrations.AddStartsOnToCurrencies do
  use Ecto.Migration

  def change do
    alter table(:currencies) do
      add :starts_on, :date
    end
  end
end
