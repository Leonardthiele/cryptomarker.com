defmodule PlatformWeb.CurrencyLinkController do
  use PlatformWeb, :controller

  alias Platform.Core
  alias Platform.Core.Schema.CurrencyLink

  def new(conn, %{"currency_id" => currency_id}) do
    currency = load_currency(currency_id)

    changeset = Core.change_currency_link(currency, %CurrencyLink{})
    render(conn, "new.html", currency: currency, changeset: changeset)
  end

  def create(conn, %{"currency_id" => currency_id, "currency_link" => currency_link_params}) do
    currency = load_currency(currency_id)

    case Core.create_currency_link(currency, currency_link_params) do
      {:ok, _currency_link} ->
        Core.update_currency_completeness_score(currency)

        conn
        |> put_flash(:info, "Currency link created successfully.")
        |> redirect(to: currency_path(conn, :show, currency))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", currency: currency, changeset: changeset)
    end
  end

  def edit(conn, %{"currency_id" => currency_id, "id" => id}) do
    currency = load_currency(currency_id)

    currency_link = Core.get_currency_link!(currency, id)
    changeset = Core.change_currency_link(currency, currency_link)
    render(conn, "edit.html", currency: currency, currency_link: currency_link, changeset: changeset)
  end

  def update(conn, %{"currency_id" => currency_id, "id" => id, "currency_link" => currency_link_params}) do
    currency = load_currency(currency_id)

    currency_link = Core.get_currency_link!(currency, id)

    case Core.update_currency_link(currency_link, currency_link_params) do
      {:ok, _currency_link} ->
        Core.update_currency_completeness_score(currency)

        conn
        |> put_flash(:info, "Currency link updated successfully.")
        |> redirect(to: currency_path(conn, :show, currency))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", currency: currency, currency_link: currency_link, changeset: changeset)
    end
  end

  def delete(conn, %{"currency_id" => currency_id, "id" => id}) do
    currency = load_currency(currency_id)

    currency_link = Core.get_currency_link!(currency, id)
    {:ok, _currency_link} = Core.delete_currency_link(currency_link)
    Core.update_currency_completeness_score(currency)

    conn
    |> put_flash(:info, "Currency link deleted successfully.")
    |> redirect(to: currency_path(conn, :show, currency))
  end

  # Private functions
  defp load_currency(id) do
    Core.get_currency!(id)
  end
end
