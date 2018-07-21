defmodule PlatformWeb.CurrencyRatingControllerTest do
  use PlatformWeb.ConnCase

  setup :login_as_admin
  setup :create_user

  describe "#index" do
    setup :create_currency_rating

    test "lists all currency_ratings", %{conn: conn, user: user, currency_rating: currency_rating} do
      conn = get conn, user_currency_rating_path(conn, :index, user)
      assert html_response(conn, 200) =~ currency_rating.currency.name
    end
  end

  describe "#create" do
    setup :create_currency

    test "redirects to show when data is valid and rating doesnt exist", %{conn: orig_conn, user: user, currency: currency} do
      conn = post orig_conn, user_currency_rating_path(orig_conn, :create, user, currency_id: currency.id, rating: 1)

      assert redirected_to(conn) == currency_path(conn, :index)

      conn = get orig_conn, currency_path(orig_conn, :index)
      assert html_response(conn, 200) =~ "★"
    end
  end

  describe "#update" do
    setup :create_currency_rating

    test "redirects to show when data is valid and rating does exist", %{conn: orig_conn, user: user, currency_rating: currency_rating} do
      conn = post orig_conn, user_currency_rating_path(orig_conn, :create, user, currency_id: currency_rating.currency_id, rating: "-1")

      assert redirected_to(conn) == currency_path(conn, :index)

      conn = get orig_conn, currency_path(orig_conn, :index)
      assert html_response(conn, 200) =~ "★"
    end
  end


  describe "#delete" do
    setup :create_currency_rating

    test "deletes chosen currency_rating", %{conn: conn, user: user, currency_rating: currency_rating} do
      conn = delete conn, user_currency_rating_path(conn, :delete, user, currency_rating.currency_id)
      assert redirected_to(conn) == currency_path(conn, :index)
    end
  end

  # Private functions
  defp create_user(_) do
    user = Factory.insert(:user)
    {:ok, user: user}
  end

  defp create_currency(_) do
    currency = Factory.insert(:currency)
    {:ok, currency: currency}
  end

  defp create_currency_rating(%{user: user}) do
    currency_rating = Factory.insert(:currency_rating, user: user)
    {:ok, currency_rating: currency_rating}
  end
end
