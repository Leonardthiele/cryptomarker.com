defmodule Platform.Repo.Migrations.AddUserIdToRatingFactors do
  use Ecto.Migration

  def change do
    # drop unique_index(:rating_factors, [:field])

    alter table(:rating_factors) do
      add :user_id, references(:users), null: true
    end

    create unique_index(:rating_factors, [:user_id, :field])
  end
end
