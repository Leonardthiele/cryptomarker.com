defmodule Platform.Repo.Migrations.AddAutoManagedToExchanges do
  use Ecto.Migration

  def change do
    alter table(:exchanges) do
      add :auto_managed, :boolean, null: false, default: false
    end
  end
end
