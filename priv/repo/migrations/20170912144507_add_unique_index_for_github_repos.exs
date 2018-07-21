defmodule Platform.Repo.Migrations.AddUniqueIndexForGithubRepos do
  use Ecto.Migration

  def change do
    create unique_index(:github_repos, [:full_name])
  end
end
