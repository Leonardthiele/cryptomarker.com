defmodule PlatformWeb.GithubRepoController do
  use PlatformWeb, :controller
  require Ecto.Query

  alias Platform.Social.Schema.GithubRepo
  alias Platform.Social
  alias Platform.Core

  def new(conn, %{"currency_id" => currency_id}) do
    currency = Core.get_currency!(currency_id)

    changeset =
      %GithubRepo{}
      |> GithubRepo.changeset(%{})

    render(conn, "new.html", currency: currency, changeset: changeset)
  end

  def create(conn, %{"currency_id" => currency_id, "github_repo" => github_repo_params}) do
    currency = Core.get_currency!(currency_id)

    case Social.create_github_repo(currency, github_repo_params) do
      {:ok, _github_repo} ->
        # Platform.Social.GithubRepoApiUpdater.update(github_repo)

        conn
        |> put_flash(:info, "Github repo created successfully.")
        |> redirect(to: currency_path(conn, :show, currency))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", currency: currency, changeset: changeset)
    end
  end

  def delete(conn, %{"currency_id" => currency_id, "id" => id}) do
    currency = Core.get_currency!(currency_id)
    github_repo = Social.get_github_repo!(currency, id)

    {:ok, _github_repo} = Social.delete_github_repo(github_repo)

    conn
    |> put_flash(:info, "Github repo deleted successfully.")
    |> redirect(to: currency_path(conn, :show, currency))
  end
end
