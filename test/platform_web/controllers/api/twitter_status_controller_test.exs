defmodule PlatformWeb.Api.TwitterStatusControllerTest do
  use PlatformWeb.ConnCase

  setup :create_currency

  describe "#index" do
    setup :create_twitter_status

    test "lists all twitter statuses", %{conn: conn, currency: currency, twitter_status: twitter_status} do
      conn = get conn, api_twitter_status_path(conn, :index, currency_id: currency.id)

      body = json_response(conn, 200)
      assert List.first(body)["text"] == twitter_status.text
    end
  end

  # Private functions
  defp create_currency(_) do
    currency = Factory.insert(:currency)
    {:ok, currency: currency}
  end

  defp create_twitter_status(%{currency: currency}) do
    twitter_account = Factory.insert(:twitter_account, currency: currency)
    twitter_status = Factory.insert(:twitter_status, twitter_user_id: twitter_account.twitter_user_id)
    {:ok, twitter_status: twitter_status}
  end
end
