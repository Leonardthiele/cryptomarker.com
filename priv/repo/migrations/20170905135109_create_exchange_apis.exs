defmodule Platform.Repo.Migrations.CreateExchangeApis do
  use Ecto.Migration

  def change do
    create table(:exchange_apis) do
      add :exchange_id, references(:exchanges), null: false
      add :active, :boolean, default: true, null: false
      add :docs_url, :string
      add :root, :string
      add :type, :string
      add :symbol, :string
      add :mappings, :text
      timestamps()
    end
  end
end
