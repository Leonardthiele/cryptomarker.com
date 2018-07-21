defmodule Platform.Social.TwitterStatusApiTest do
  use Platform.DataCase
  use ExVCR.Mock, adapter: ExVCR.Adapter.Httpc

  alias Platform.Social
  alias Platform.Social.TwitterStatusApi

  doctest TwitterStatusApi

  setup_all do
    ExVCR.Config.filter_url_params(true)
    ExVCR.Config.filter_sensitive_data("oauth_signature=[^\"]+", "<REMOVED>")
    ExVCR.Config.filter_sensitive_data("guest_id=.+;", "<REMOVED>")
    ExVCR.Config.filter_sensitive_data("access_token\":\".+?\"", "access_token\":\"<REMOVED>\"")

    ExTwitter.configure(
      consumer_key:        System.get_env("TWITTER_CONSUMER_KEY"),
      consumer_secret:     System.get_env("TWITTER_CONSUMER_SECRET"),
      access_token:        System.get_env("TWITTER_ACCESS_TOKEN"),
      access_token_secret: System.get_env("TWITTER_ACCESS_SECRET")
      # consumer_key: "FdYQkndqqngAguL9ePHvTM0KM",
      # consumer_secret: "kItCGHAnHtytlQbOfiNxYN6uIj60LABWthn5JpYDuIt1iA0E8Z",
      # access_token: "900366673844326402-K351lsSosG01SXCIAJOWj6KfViJb7k5",
      # access_token_secret: "OzqvTMrO3FtbrMa8taPOlUNirZzGqAWvR6AEx9xNA6ltS"
    )

    :ok
  end

  describe "#update_all" do
    test "get the coinlist" do
      use_cassette "home_timeline#all" do
        TwitterStatusApi.update_from_home_timeline(1)
        [twitter_status] = Social.list_twitter_statuses()

        assert twitter_status.id == 910272041605107713
        assert twitter_status.favorites_count == 0
        assert twitter_status.lang == "en"
        assert twitter_status.screen_name == "MonetaryUnit"
        assert twitter_status.text == "Why cryptocurrency?\n&amp;\nWhy MonetaryUnit?\n#cryptocurrency #financialfreedom #monetaryunit\nhttps://t.co/bcK5pcHQWQ https://t.co/zrBtQ99O9I"
      end
    end
  end
end
