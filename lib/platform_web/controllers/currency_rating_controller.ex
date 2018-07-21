defmodule PlatformWeb.CurrencyRatingController do
  use PlatformWeb, :controller

  alias Platform.Accounts

  def index(conn, %{"user_id" => user_id}) do
    user = Accounts.get_user!(user_id)

    currency_ratings = Accounts.list_currency_ratings(user)

    render(conn, "index.html", user: user, currency_ratings: currency_ratings)
  end

  def create(conn, %{"user_id" => user_id, "currency_id" => currency_id, "rating" => rating}) do
    user = Accounts.get_user!(user_id)

    currency_rating =
      user
      |> Accounts.get_or_build_currency_rating(currency_id)
      |> authorize_action!(conn)

    currency_rating
    |> Accounts.insert_or_update_currency_rating(%{rating: rating})

    conn
    |> put_flash(:info, "Rating status changed.")
    |> redirect(to: currency_path(conn, :index))
  end

  def delete(conn, %{"user_id" => user_id, "id" => currency_id}) do
    user = Accounts.get_user!(user_id)

    currency_rating =
      user
      |> Accounts.get_or_build_currency_rating(currency_id)
      |> authorize_action!(conn)

    Accounts.delete_currency_rating(currency_rating)

    conn
    |> put_flash(:info, "Rating deleted.")
    |> redirect(to: currency_path(conn, :index))
  end
end
