defmodule PlatformWeb.RedditControllerTest do
  use PlatformWeb.ConnCase

  @create_attrs Factory.params_for(:reddit)
  @invalid_attrs %{name: nil}

  setup :login_as_admin
  setup :create_currency

  describe "#new" do
    test "renders form", %{conn: conn, currency: currency} do
      conn = get conn, currency_reddit_path(conn, :new, currency)
      assert html_response(conn, 200) =~ "New reddit"
    end
  end

  describe "#create" do
    test "redirects to show when data is valid", %{conn: orig_conn, currency: currency} do
      conn = post orig_conn, currency_reddit_path(orig_conn, :create, currency), reddit: @create_attrs

      assert %{id: _id} = redirected_params(conn)
      assert redirected_to(conn) == currency_path(conn, :show, currency)

      conn = get orig_conn, currency_path(conn, :show, currency)
      assert html_response(conn, 200) =~ @create_attrs.name
    end

    test "renders errors when data is invalid", %{conn: conn, currency: currency} do
      conn = post conn, currency_reddit_path(conn, :create, currency), reddit: @invalid_attrs
      assert html_response(conn, 200) =~ "New reddit"
    end
  end

  describe "#delete" do
    setup :create_reddit

    test "deletes chosen reddit", %{conn: orig_conn, currency: currency, reddit: reddit} do
      conn = delete orig_conn, currency_reddit_path(orig_conn, :delete, currency, reddit)
      assert redirected_to(conn) == currency_path(conn, :show, currency)

      conn = get orig_conn, currency_path(orig_conn, :show, currency)
      refute html_response(conn, 200) =~ reddit.name
    end
  end

  # Private functions
  defp create_currency(_) do
    currency = Factory.insert(:currency)
    {:ok, currency: currency}
  end

  defp create_reddit(%{currency: currency}) do
    reddit = Factory.insert(:reddit, currency: currency)
    {:ok, reddit: reddit}
  end
end
