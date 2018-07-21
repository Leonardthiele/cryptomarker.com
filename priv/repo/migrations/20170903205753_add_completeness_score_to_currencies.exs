defmodule Platform.Repo.Migrations.AddCompletenessScoreToCurrencies do
  use Ecto.Migration

  def change do
    alter table(:currencies) do
      add :completeness_score, :float, default: 0.0
    end
  end
end
