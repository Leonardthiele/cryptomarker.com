defmodule Platform.Core.CurrencyCompletenessScore do
  @moduledoc false
  alias Platform.Core.Schema.Currency
  alias Platform.Util.Score

  @doc """
  Calculates a completeness percentage score from a currency

  ## Examples

      iex> CurrencyCompletenessScore.result(%Currency{logo: "eth.png", short_summary: "The first blockchain currency."})
      0.17391304347826086
  """
  def result(%Currency{} = currency) do
    currency
    |> conditions
    |> Score.calculate_percentage
  end

  def conditions(%Currency{} = currency) do
    [
      {2, logo_score(currency)},
      {2, short_summary_score(currency)},
      {4, website_link_score(currency)},
      {4, twitter_score(currency)},
      {4, reddit_score(currency)},
      {4, github_score(currency)},
      {2, whitepaper_link_score(currency)},
      {1, explorer_link_score(currency)}
    ]
  end

  def logo_score(%Currency{logo: logo}), do: not(is_nil(logo))
  def logo_score(_), do: false

  def short_summary_score(%Currency{short_summary: short_summary}) when is_binary(short_summary) do
    String.length(short_summary) > 20
  end
  def short_summary_score(_), do: false

  def website_link_score(%Currency{currency_links: currency_links}) do
    check_for_link_type(currency_links, "website")
  end
  def website_link_score(_), do: false

  def whitepaper_link_score(%Currency{currency_links: currency_links}) do
    check_for_link_type(currency_links, "whitepaper")
  end
  def whitepaper_link_score(_), do: false

  def explorer_link_score(%Currency{currency_links: currency_links}) do
    check_for_link_type(currency_links, "explorer")
  end
  def explorer_link_score(_), do: false

  def twitter_score(%Currency{twitter_accounts: twitter_accounts}) when is_list(twitter_accounts) do
    Enum.count(twitter_accounts) > 0
  end
  def twitter_score(_), do: false

  def reddit_score(%Currency{reddits: reddits}) when is_list(reddits) do
    Enum.count(reddits) > 0
  end
  def reddit_score(_), do: false

  def github_score(%Currency{github_repos: github_repos}) when is_list(github_repos) do
    Enum.count(github_repos) > 0
  end
  def github_score(_), do: false

  @doc """
  Helper function to search for a specific type in currency links

  iex> CurrencyCompletenessScore.check_for_link_type([%{type: "website"}], "website")
  true

  iex> CurrencyCompletenessScore.check_for_link_type([%{type: "whitepaper"}], "website")
  false

  iex> CurrencyCompletenessScore.check_for_link_type([], "whatever")
  false
  """
  def check_for_link_type([], _), do: false
  def check_for_link_type(links, type) when is_list(links) do
    Enum.count(links, fn(link) -> link.type == type end) > 0
  end
  def check_for_link_type(_, _), do: false
end
