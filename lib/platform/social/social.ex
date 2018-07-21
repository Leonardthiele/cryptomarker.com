defmodule Platform.Social do
  @moduledoc """
  The Social context.
  """
  import Ecto.Query, warn: false
  import Ecto

  alias Platform.Repo
  alias Platform.Social.Schema.GithubRepo
  alias Platform.Social.Schema.TwitterAccount
  alias Platform.Social.Schema.TwitterStatus
  alias Platform.Social.Schema.Reddit

  ### ################################################################### ###
  ### GithubRepo                                                          ###
  ### ################################################################### ###
  @doc "Returns a list of github repos which are not updated for 2 hours"
  def list_github_repos_to_be_updated(limit) do
    two_hours_ago = Calendar.DateTime.add!(Calendar.DateTime.now_utc, -2 * 3600)

    GithubRepo
    |> Ecto.Query.order_by([asc: :updated_at])
    |> Ecto.Query.where([q], q.updated_at < ^two_hours_ago)
    |> Ecto.Query.limit(^limit)
    |> Repo.all()
  end

  def get_github_repo!(currency, id) do
    currency
    |> Ecto.assoc(:github_repos)
    |> Repo.get!(id)
  end

  def create_github_repo(currency, attrs \\ %{}) do
    %GithubRepo{currency_id: currency.id}
    |> GithubRepo.changeset(attrs)
    |> Repo.insert()
  end

  def update_github_repo_api(%GithubRepo{} = github_repo, attrs) do
    github_repo
    |> GithubRepo.api_changeset(attrs)
    |> Repo.update()
  end

  def delete_github_repo(%GithubRepo{} = github_repo) do
    Repo.delete(github_repo)
  end

  ### ################################################################### ###
  ### TwitterAccount                                                      ###
  ### ################################################################### ###
  def list_twitter_accounts(currency) do
    currency
    |> assoc(:twitter_accounts)
    |> Repo.all
  end

  def get_twitter_account!(currency, id) do
    currency
    |> assoc(:twitter_accounts)
    |> Repo.get!(id)
  end

  def create_twitter_account(currency, attrs \\ %{}) do
    %TwitterAccount{currency_id: currency.id}
    |> TwitterAccount.changeset(attrs)
    |> Repo.insert()
  end

  def delete_twitter_account(%TwitterAccount{} = twitter_account) do
    Repo.delete(twitter_account)
  end

  def change_twitter_account(%TwitterAccount{} = twitter_account) do
    TwitterAccount.changeset(twitter_account, %{})
  end

  ### ################################################################### ###
  ### TwitterStatus                                                       ###
  ### ################################################################### ###
  def list_twitter_statuses(%TwitterAccount{} = twitter_account) do
    twitter_account
    |> Ecto.assoc(:twitter_statuses)
    |> Ecto.Query.order_by([desc: :id])
    |> Ecto.Query.preload([twitter_accounts: :currency])
    |> Repo.all
  end
  def list_twitter_statuses(currency) do
    currency
    |> Ecto.assoc([:twitter_accounts, :twitter_statuses])
    |> Ecto.Query.where(unimportant: false)
    |> Repo.all
  end

  def list_twitter_statuses_top_3(currency) do
    currency
    |> Ecto.assoc([:twitter_accounts, :twitter_statuses])
    |> Ecto.Query.order_by([desc: :id])
    |> Ecto.Query.limit(3)
    |> Repo.all
  end

  def list_twitter_statuses do
    TwitterStatus
    |> Repo.all
  end

  def paginate_twitter_statuses(params) do
    TwitterStatus
    |> Ecto.Query.order_by([desc: :id])
    |> Ecto.Query.where(unimportant: false)
    |> Ecto.Query.preload([twitter_accounts: :currency])
    |> Repo.paginate(params)
  end

  def top_twitter_statuses do
    two_hours_ago = Calendar.DateTime.add!(Calendar.DateTime.now_utc, -2 * 3600)

    TwitterStatus
    |> Ecto.Query.where([q], q.inserted_at > ^two_hours_ago)
    |> Ecto.Query.where(unimportant: false)
    |> Ecto.Query.order_by([desc: :retweets_count])
    |> Ecto.Query.preload([twitter_accounts: :currency])
    |> Ecto.Query.limit(20)
    |> Repo.all
  end

  def get_twitter_status!(id) do
    TwitterStatus
    |> Ecto.Query.preload([twitter_accounts: :currency])
    |> Repo.get!(id)
  end

  def update_twitter_status(%TwitterStatus{} = twitter_status, attrs) do
    twitter_status
    |> TwitterStatus.changeset(attrs)
    |> Repo.update()
  end

  def toggle_twitter_status_unimportant(%TwitterStatus{} = twitter_status) do
    twitter_status
    |> Repo.toggle(:unimportant)
  end

  ### ################################################################### ###
  ### Reddit                                                              ###
  ### ################################################################### ###
  def get_reddit!(currency, id) do
    currency
    |> Ecto.assoc(:reddits)
    |> Repo.get!(id)
  end

  def create_reddit(currency, attrs \\ %{}) do
    %Reddit{currency_id: currency.id}
    |> Reddit.changeset(attrs)
    |> Repo.insert()
  end

  def delete_reddit(%Reddit{} = reddit) do
    Repo.delete(reddit)
  end
end
