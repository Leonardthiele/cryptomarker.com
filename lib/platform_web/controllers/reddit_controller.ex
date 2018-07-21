defmodule PlatformWeb.RedditController do
  use PlatformWeb, :controller
  require Ecto.Query

  alias Platform.Core
  alias Platform.Social
  alias Platform.Social.Schema.Reddit

  def new(conn, %{"currency_id" => currency_id}) do
    currency = Core.get_currency!(currency_id)

    changeset =
      %Reddit{}
      |> Reddit.changeset(%{})

    render(conn, "new.html", currency: currency, changeset: changeset)
  end

  def create(conn, %{"currency_id" => currency_id, "reddit" => reddit_params}) do
    currency = Core.get_currency!(currency_id)

    case Social.create_reddit(currency, reddit_params) do
      {:ok, _reddit} ->

        conn
        |> put_flash(:info, "Reddit created successfully.")
        |> redirect(to: currency_path(conn, :show, currency))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", currency: currency, changeset: changeset)
    end
  end

  def delete(conn, %{"currency_id" => currency_id, "id" => id}) do
    currency = Core.get_currency!(currency_id)
    reddit = Social.get_reddit!(currency, id)

    {:ok, _reddit} = Social.delete_reddit(reddit)

    conn
    |> put_flash(:info, "Reddit deleted successfully.")
    |> redirect(to: currency_path(conn, :show, currency))
  end
end
