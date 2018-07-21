defmodule Platform.Repo.Migrations.CreateGithubRepos do
  use Ecto.Migration

  def change do
    create table(:github_repos) do
      add :currency_id, references(:currencies), null: false
      add :full_name, :string, null: false, limit: 64
      add :stars_count, :integer, default: 0, null: false
      add :forks_count, :integer, default: 0, null: false
      add :watchers_count, :integer, default: 0, null: false
      add :open_issues_count, :integer, default: 0, null: false
      timestamps()
    end
  end
end
