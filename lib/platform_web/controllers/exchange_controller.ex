defmodule PlatformWeb.ExchangeController do
  alias Platform.Exchanges
  alias Platform.Exchanges.Schema.Exchange
  use PlatformWeb, :controller

  def index(conn, _params) do
    Exchange |> authorize_action!(conn)

    exchanges = Exchanges.list_exchanges()
    render(conn, "index.html", exchanges: exchanges)
  end

  def new(conn, _params) do
    Exchange |> authorize_action!(conn)

    changeset = Exchanges.change_exchange(%Exchange{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"exchange" => exchange_params}) do
    Exchange |> authorize_action!(conn)

    case Exchanges.create_exchange(exchange_params) do
      {:ok, exchange} ->
        conn
        |> put_flash(:info, "Exchange created successfully.")
        |> redirect(to: exchange_path(conn, :show, exchange))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    exchange = id |> Exchanges.get_exchange! |> authorize_action!(conn)

    PlatformWeb.Endpoint.broadcast! "exchange:#{id}", "drop", %{
      currency_name: "Bitcoin",
      exchange_name: exchange.name,
      url: exchange_url(conn, :show, exchange),
      value: -0.10
    }

    render(conn, "show.html", exchange: exchange)
  end

  def edit(conn, %{"id" => id}) do
    exchange = id |> Exchanges.get_exchange! |> authorize_action!(conn)

    changeset = Exchanges.change_exchange(exchange)
    render(conn, "edit.html", exchange: exchange, changeset: changeset)
  end

  def update(conn, %{"id" => id, "exchange" => exchange_params}) do
    exchange = id |> Exchanges.get_exchange! |> authorize_action!(conn)

    case Exchanges.update_exchange(exchange, exchange_params) do
      {:ok, exchange} ->
        conn
        |> put_flash(:info, "Exchange updated successfully.")
        |> redirect(to: exchange_path(conn, :show, exchange))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", exchange: exchange, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    exchange = id |> Exchanges.get_exchange! |> authorize_action!(conn)
    {:ok, _exchange} = Exchanges.delete_exchange(exchange)

    conn
    |> put_flash(:info, "Exchange deleted successfully.")
    |> redirect(to: exchange_path(conn, :index))
  end
end
