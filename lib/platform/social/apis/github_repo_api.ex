defmodule Platform.Social.GithubRepoApi do
  @moduledoc """
  Fetches the all the latest stats from a GitHub Repository.
  Uses the GitHub Api. Updates the current state every two hours.
  See scheduler in config.exs
  Interval: 3 repos / minute
  """
  require Logger

  alias Platform.Social
  alias Platform.Social.Schema.GithubRepo

  @doc """
  Gets the list of repos to be updated and updates them.
  """
  def update_all do
    Logger.info("Updating GitHub repositories")

    github_repos = Social.list_github_repos_to_be_updated(3)

    Enum.each github_repos, fn(github_repo) ->
      update_github_repo(github_repo)
    end
  end

  def update_github_repo(%GithubRepo{full_name: full_name} = github_repo) do
    result = get_github_repo(full_name)

    changes = %{
      stars_count: result["stargazers_count"],
      forks_count: result["forks_count"],
      watchers_count: result["watchers_count"],
      open_issues_count: result["open_issues"]
    }

    github_repo
    |> Social.update_github_repo_api(changes)
  end

  # Private functions
  defp get_github_repo(repository) do
    HTTPoison.get!("https://api.github.com/repos/#{repository}").body
    |> Poison.decode!
  end
end
