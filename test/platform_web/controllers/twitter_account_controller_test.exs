defmodule PlatformWeb.TwitterAccountControllerTest do
  use PlatformWeb.ConnCase

  # alias Platform.Core

#   @create_attrs %{currency_id: 42, followers_count: 42, image_url: "some image_url", name: "some name", tweets_count: 42}
#   @update_attrs %{currency_id: 43, followers_count: 43, image_url: "some updated image_url", name: "some updated name", tweets_count: 43}
#   @invalid_attrs %{currency_id: nil, followers_count: nil, image_url: nil, name: nil, tweets_count: nil}

  setup :login_as_admin
  setup :create_currency

  describe "#index" do
    setup :create_twitter_account

    test "lists all twitter_accounts", %{conn: conn, currency: currency, twitter_account: twitter_account} do
      conn = get conn, currency_twitter_account_path(conn, :index, currency)
      assert html_response(conn, 200) =~ twitter_account.screen_name
    end
  end

  describe "#show" do
    setup :create_twitter_account

    test "renders the chosen twitter_account", %{conn: conn, currency: currency, twitter_account: twitter_account} do
      conn = get conn, currency_twitter_account_path(conn, :show, currency, twitter_account)
      assert html_response(conn, 200) =~ twitter_account.name
    end
  end

  describe "#new" do
    test "renders form", %{conn: conn, currency: currency} do
      conn = get conn, currency_twitter_account_path(conn, :new, currency)
      assert html_response(conn, 200) =~ "New twitter account"
    end
  end

#   describe "create twitter_account" do
#     test "redirects to show when data is valid", %{conn: conn} do
#       conn = post conn, currency_twitter_account_path(conn, :create), twitter_account: @create_attrs

#       assert %{id: id} = redirected_params(conn)
#       assert redirected_to(conn) == currency_twitter_account_path(conn, :show, id)

#       conn = get conn, currency_twitter_account_path(conn, :show, id)
#       assert html_response(conn, 200) =~ "Show Twitter account"
#     end

#     test "renders errors when data is invalid", %{conn: conn} do
#       conn = post conn, currency_twitter_account_path(conn, :create), twitter_account: @invalid_attrs
#       assert html_response(conn, 200) =~ "New Twitter account"
#     end
#   end

#   describe "delete twitter_account" do
#     setup :create_twitter_account

#     test "deletes chosen twitter_account", %{conn: conn, twitter_account: twitter_account} do
#       conn = delete conn, currency_twitter_account_path(conn, :delete, twitter_account)
#       assert redirected_to(conn) == currency_twitter_account_path(conn, :index)
#       assert_error_sent 404, fn ->
#         get conn, currency_twitter_account_path(conn, :show, twitter_account)
#       end
#     end
#   end

  # Private functions
  defp create_currency(_) do
    currency = Factory.insert(:currency)
    {:ok, currency: currency}
  end

  defp create_twitter_account(%{currency: currency}) do
    twitter_account = Factory.insert(:twitter_account, currency: currency, name: "Bitcoin")
    {:ok, twitter_account: twitter_account}
  end
end
