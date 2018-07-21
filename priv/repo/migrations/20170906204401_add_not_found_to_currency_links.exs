defmodule Platform.Repo.Migrations.AddNotFoundToCurrencyLinks do
  use Ecto.Migration

  def change do
    alter table(:currency_links) do
      add :not_found, :boolean, null: false, default: false
    end
  end
end
