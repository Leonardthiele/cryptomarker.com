defmodule PlatformWeb.ExchangeCurrencyController do
  use PlatformWeb, :controller

  alias Platform.Exchanges
  alias Platform.Core
  alias Platform.Exchanges.Schema.ExchangeCurrency

  def new(conn, %{"exchange_id" => exchange_id}) do
    exchange = Exchanges.get_exchange!(exchange_id)

    changeset = Exchanges.change_exchange_currency(exchange, %ExchangeCurrency{})
    render(conn, "new.html", exchange: exchange, changeset: changeset, collections: collections(conn))
  end

  def create(conn, %{"exchange_id" => exchange_id, "exchange_currency" => exchange_currency_params}) do
    exchange = Exchanges.get_exchange!(exchange_id)

    case Exchanges.create_exchange_currency(exchange, exchange_currency_params) do
      {:ok, _exchange_currency} ->
        conn
        |> put_flash(:info, "Exchange currency created successfully.")
        |> redirect(to: exchange_path(conn, :show, exchange))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", exchange: exchange, changeset: changeset, collections: collections(conn))
    end
  end

  def edit(conn, %{"exchange_id" => exchange_id, "id" => id}) do
    exchange = Exchanges.get_exchange!(exchange_id)

    exchange_currency = Exchanges.get_exchange_currency!(exchange, id)
    changeset = Exchanges.change_exchange_currency(exchange, exchange_currency)
    render(conn, "edit.html", exchange: exchange, exchange_currency: exchange_currency, changeset: changeset, collections: collections(conn))
  end

  def update(conn, %{"exchange_id" => exchange_id, "id" => id, "exchange_currency" => exchange_currency_params}) do
    exchange = Exchanges.get_exchange!(exchange_id)

    exchange_currency = Exchanges.get_exchange_currency!(exchange, id)

    case Exchanges.update_exchange_currency(exchange, exchange_currency, exchange_currency_params) do
      {:ok, _exchange_currency} ->
        conn
        |> put_flash(:info, "Exchange currency updated successfully.")
        |> redirect(to: exchange_path(conn, :show, exchange))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", exchange: exchange, exchange_currency: exchange_currency, changeset: changeset, collections: collections(conn))
    end
  end

  def delete(conn, %{"exchange_id" => exchange_id, "id" => id}) do
    exchange = Exchanges.get_exchange!(exchange_id)

    exchange_currency = Exchanges.get_exchange_currency!(exchange, id)
    {:ok, _exchange_currency} = Exchanges.delete_exchange_currency(exchange, exchange_currency)

    conn
    |> put_flash(:info, "Exchange currency deleted successfully.")
    |> redirect(to: exchange_path(conn, :show, exchange))
  end

  # Private functions
  defp collections(_conn) do
    %{
      currencies:
        Core.list_currencies_by_name()
    }
  end
end
