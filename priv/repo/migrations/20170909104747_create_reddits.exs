defmodule Platform.Repo.Migrations.CreateReddits do
  use Ecto.Migration

  def change do
    create table(:reddits) do
      add :currency_id, references(:currencies), null: false
      add :name, :string, null: false, limit: 64
      add :subscribers_count, :integer, default: 0, null: false
      add :active_users_count, :integer, default: 0, null: false
      add :posts_per_hour, :integer, default: 0, null: false
      add :posts_per_day, :integer, default: 0, null: false
      add :comments_per_hour, :integer, default: 0, null: false
      add :comments_per_day, :integer, default: 0, null: false
      timestamps()
    end
  end
end
