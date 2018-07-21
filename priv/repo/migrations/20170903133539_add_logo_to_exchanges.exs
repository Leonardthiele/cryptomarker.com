defmodule Platform.Repo.Migrations.AddLogoToExchanges do
  use Ecto.Migration

  def change do
    alter table(:exchanges) do
      add :logo, :string, limit: 64
    end
  end
end
