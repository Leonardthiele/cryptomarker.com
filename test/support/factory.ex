defmodule Platform.Factory do
  use ExMachina.Ecto, repo: Platform.Repo

  def candle_factory do
    %Platform.Core.Schema.Candle{
      currency: build(:currency),
      currency_symbol: "BTC",
      currency_to: "USD",
      time: "1503505920",
      open: 4236.35,
      high: 4237.55,
      close: 4236.75,
      low: 4236.3,
      volume_from: 27.82,
      volume_to: 119111.96
    }
  end

  def currency_factory do
    %Platform.Core.Schema.Currency{
      name: "Bitcoin",
      symbol: "BTC",
      slug: "bitcoin"
    }
  end

  def currency_link_factory do
    %Platform.Core.Schema.CurrencyLink{
      currency: build(:currency),
      type: "website",
      url: "https://www.bitcoin.com/"
    }
  end

  def currency_rating_factory do
    %Platform.Accounts.Schema.CurrencyRating{
      user: build(:user),
      currency: build(:currency),
      rating: 1
    }
  end

  def exchange_factory do
    %Platform.Exchanges.Schema.Exchange{
      name: "Bittrex",
      country: "US",
      website_url: "https://bittrex.com/"
    }
  end

  def exchange_currency_factory do
    %Platform.Exchanges.Schema.ExchangeCurrency{
      exchange: build(:exchange),
      currency: build(:currency),
      active: true
    }
  end

  def github_repo_factory do
    %Platform.Social.Schema.GithubRepo{
      currency: build(:currency),
      full_name: "bitcoin/bitcoin"
    }
  end

  def reddit_factory do
    %Platform.Social.Schema.Reddit{
      currency: build(:currency),
      name: "bitcoinTest"
    }
  end

  def post_factory do
    %Platform.CMS.Schema.Post{
      slug: sequence(:slug, &"blockchain-tutorial-#{&1}"),
      title: "Blockchain Tutorial",
      description: "A Blockchain Tutorial",
      content_markdown: "Hello World!"
    }
  end

  def user_factory do
    %Platform.Accounts.Schema.User{
      name: "Jane Smith",
      github_uid: "473892742",
      email: sequence(:email, &"email-#{&1}@example.com"),
    }
  end

  def twitter_account_factory do
    %Platform.Social.Schema.TwitterAccount{
      twitter_user_id: 357312062,
      screen_name: "bitcoin"
    }
  end

  def twitter_status_factory do
    %Platform.Social.Schema.TwitterStatus{
      twitter_user_id: 2312333412,
      screen_name: "ethereumproject",
      text: "[Developer Update] Ethereum Core Developers Meeting #14",
      lang: "en",
      retweets_count: 87,
      favorites_count: 129,
      unimportant: false,
      rating: 1
    }
  end
end
