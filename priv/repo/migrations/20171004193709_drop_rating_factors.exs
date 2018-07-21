defmodule Platform.Repo.Migrations.DropRatingFactors do
  use Ecto.Migration

  def change do
    drop table(:rating_factors)
  end
end
