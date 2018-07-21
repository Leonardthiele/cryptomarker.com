defmodule Platform.Repo.Migrations.RemoveGithubFieldsFromCurrencies do
  use Ecto.Migration

  def change do
    alter table(:currencies) do
      remove :github_repository
      remove :github_stars_count
      remove :github_forks_count
      remove :github_watchers_count
      remove :github_open_issues_count
    end
  end
end
