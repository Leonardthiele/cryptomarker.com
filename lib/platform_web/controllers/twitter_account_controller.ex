defmodule PlatformWeb.TwitterAccountController do
  use PlatformWeb, :controller
  require Ecto.Query

  alias Platform.Core
  alias Platform.Social
  alias Platform.Social.Schema.TwitterAccount

  def index(conn, %{"currency_id" => currency_id}) do
    currency = Core.get_currency!(currency_id)
    twitter_accounts = Social.list_twitter_accounts(currency)

    render(conn, "index.html", currency: currency, twitter_accounts: twitter_accounts)
  end

  def show(conn, %{"currency_id" => currency_id, "id" => id}) do
    currency = Core.get_currency!(currency_id)
    twitter_account = Social.get_twitter_account!(currency, id)

    twitter_statuses =
      twitter_account
      |> Social.list_twitter_statuses

    render(conn, "show.html", currency: currency, twitter_account: twitter_account, twitter_statuses: twitter_statuses)
  end

  def new(conn, %{"currency_id" => currency_id}) do
    currency = Core.get_currency!(currency_id)
    changeset = Social.change_twitter_account(%TwitterAccount{})
    render(conn, "new.html", currency: currency, changeset: changeset)
  end

  def create(conn, %{"currency_id" => currency_id, "twitter_account" => twitter_account_params}) do
    currency = Core.get_currency!(currency_id)

    twitter_params = update_twitter_params(twitter_account_params)

    case Social.create_twitter_account(currency, twitter_params) do
      {:ok, twitter_account} ->
        ExTwitter.follow(twitter_account.twitter_user_id)
        Core.update_currency_completeness_score(currency)

        conn
        |> put_flash(:info, "Twitter account created successfully.")
        |> redirect(to: currency_twitter_account_path(conn, :index, currency))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", currency: currency, changeset: changeset)
    end
  end

  def update_twitter_params(%{"screen_name" => screen_name}) do
    twitter_user = ExTwitter.user(screen_name)

    %{
      twitter_user_id: twitter_user.id,
      screen_name: twitter_user.screen_name,
      image_url: twitter_user.profile_image_url_https,
      name: twitter_user.name,
      followers_count: twitter_user.followers_count,
      tweets_count: twitter_user.statuses_count,
    }
  rescue
    _ -> %{screen_name: screen_name}
  end
  def update_twitter_params(params), do: params

  def delete(conn, %{"currency_id" => currency_id, "id" => id}) do
    currency = Core.get_currency!(currency_id)
    twitter_account = Social.get_twitter_account!(currency, id)
    ExTwitter.unfollow(twitter_account.twitter_user_id)

    {:ok, _twitter_account} = Social.delete_twitter_account(twitter_account)
    Core.update_currency_completeness_score(currency)

    conn
    |> put_flash(:info, "Twitter account deleted successfully.")
    |> redirect(to: currency_twitter_account_path(conn, :index, currency))
  end
end
