defmodule PlatformWeb.CurrencyController do
  use PlatformWeb, :controller
  require Ecto.Query

  alias Platform.Core
  alias Platform.Core.Schema.Currency
  alias Platform.Social

  def index(conn, params) do
    Currency |> authorize_action!(conn)

    avg_completeness_score = Core.get_currencies_avg_completeness_score()
    total_market_usd = Core.get_currencies_total_market_usd()

    user = current_user(conn)
    currencies = Core.query_currencies(params, user)
    render(conn, "index.html", currencies: currencies, avg_completeness_score: avg_completeness_score, total_market_usd: total_market_usd)
  end

  def new(conn, _params) do
    Currency |> authorize_action!(conn)

    changeset = Core.change_currency(%Currency{})
    render(conn, "new.html", changeset: changeset, collections: collections(conn))
  end

  def create(conn, %{"currency" => currency_params}) do
    Currency |> authorize_action!(conn)

    case Core.create_currency(currency_params) do
      {:ok, currency} ->
        Core.update_currency_completeness_score(currency)

        conn
        |> put_flash(:info, "Currency created successfully.")
        |> redirect(to: currency_path(conn, :show, currency))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, collections: collections(conn))
    end
  end

  def show(conn, %{"id" => id}) do
    currency = id |> Core.get_currency!() |> authorize_action!(conn)
    twitter_statuses = Social.list_twitter_statuses_top_3(currency)

    render(conn, "show.html", currency: currency, twitter_statuses: twitter_statuses)
  end

  def edit(conn, %{"id" => id}) do
    currency = id |> Core.get_currency!() |> authorize_action!(conn)
    changeset = Core.change_currency(currency)
    render(conn, "edit.html", currency: currency, changeset: changeset, collections: collections(conn))
  end

  def update(conn, %{"id" => id, "currency" => currency_params}) do
    currency = id |> Core.get_currency!() |> authorize_action!(conn)

    case Core.update_currency(currency, currency_params) do
      {:ok, currency} ->
        Core.update_currency_completeness_score(currency)

        conn
        |> put_flash(:info, "Currency updated successfully.")
        |> redirect(to: currency_path(conn, :show, currency))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", currency: currency, changeset: changeset, collections: collections(conn))
    end
  end

  def delete(conn, %{"id" => id}) do
    currency = id |> Core.get_currency!() |> authorize_action!(conn)
    {:ok, _currency} = Core.delete_currency(currency)

    conn
    |> put_flash(:info, "Currency deleted successfully.")
    |> redirect(to: currency_path(conn, :index))
  end

  # Private functions
  defp collections(_conn) do
    %{
      currencies: Core.list_currencies_by_name()
    }
  end
end
