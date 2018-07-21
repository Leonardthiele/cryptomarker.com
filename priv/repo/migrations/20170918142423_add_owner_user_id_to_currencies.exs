defmodule Platform.Repo.Migrations.AddOwnerUserIdToCurrencies do
  use Ecto.Migration

  def change do
    alter table(:currencies) do
      add :owner_user_id, references(:users), null: true
    end
  end
end
