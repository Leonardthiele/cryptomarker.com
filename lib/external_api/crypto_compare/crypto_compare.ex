defmodule ExternalApi.CryptoCompare do
  @moduledoc """
  Api wrapper for CryptoCompare
  """

  @doc """
  Gets the current available coinlist
  https://www.cryptocompare.com/api/data/coinlist
  """
  def coinlist, do: api_get!("coinlist")
  def coinlist(symbol), do: coinlist()[symbol]

  @doc """
  Extracts only the symbols from the coinlist
  """
  def coinlist_symbols, do: Enum.map(coinlist(), fn({symbol, _}) -> symbol end)

  @doc """
  Gets all the social stats (twitter, reddit, etc)
  https://www.cryptocompare.com/api/data/socialstats?id=1182
  """
  def socialstats(id) when is_integer(id) do
    api_get!("socialstats?id=#{id}")
  end
  def socialstats(symbol) when is_binary(symbol) do
    if id = coinlist(symbol)["Id"] do
      api_get!("socialstats?id=#{id}")
    else
      nil
    end
  end
  def socialstats(symbol, :twitter) do
    if data = socialstats(symbol) do
      data
      |> get_in(["Twitter", "link"])
      |> extract_twitter_screen_name_from_link()
    else
      nil
    end
  end
  def socialstats(symbol, :reddit) do
    if data = socialstats(symbol) do
      data
      |> get_in(["Reddit", "name"])
    else
      nil
    end
  end
  def socialstats(symbol, :github) do
    if data = socialstats(symbol) do
      data
      |> get_in(["CodeRepository", "List"])
      |> Enum.map(fn(repo) -> extract_github_full_name(repo["url"]) end)
    else
      []
    end
  end

  @doc """
  Gets a coinsnapshot
  https://www.cryptocompare.com/api/data/coinsnapshotfullbyid/?id=1182
  """
  def coinsnapshotfullbyid(id) when is_integer(id) do
    api_get!("coinsnapshotfullbyid?id=#{id}")
  end
  def coinsnapshotfullbyid(symbol) when is_binary(symbol) do
    if id = coinlist(symbol)["Id"] do
      api_get!("coinsnapshotfullbyid?id=#{id}")
    else
      nil
    end
  end
  def coinsnapshotfullbyid(symbol, :homepage) do
    if data = coinsnapshotfullbyid(symbol) do
      data
      |> get_in(["General", "AffiliateUrl"])
    else
      nil
    end
  end
  def coinsnapshotfullbyid(symbol, :starts_on) do
    if data = coinsnapshotfullbyid(symbol) do
      data
      |> get_in(["General", "StartDate"])
      |> parse_date()
    else
      nil
    end
  end

  def histominute(currency_symbol, nil) do
    min_api_get!("histominute?fsym=#{currency_symbol}&tsym=USD&limit=2000&aggregate=1&e=CCCAGG")
  end
  def histominute(currency_symbol, min_ts) do
    limit = round((DateTime.to_unix(Calendar.DateTime.now_utc) - min_ts) / 60) + 5
    min_api_get!("histominute?fsym=#{currency_symbol}&tsym=USD&limit=#{limit}&aggregate=1&e=CCCAGG")
  end

  # Private functions
  defp parse_date(nil), do: nil
  defp parse_date(str) when is_binary(str) do
    [day, month, year] = String.split(str, "/")
    Calendar.Date.Parse.iso8601!("#{year}-#{month}-#{day}")
  end

  defp extract_twitter_screen_name_from_link(nil), do: ""
  defp extract_twitter_screen_name_from_link(url) when is_binary(url) do
    url
    |> String.split("/")
    |> List.last
  end

  defp extract_github_full_name(nil), do: ""
  defp extract_github_full_name(url) when is_binary(url) do
    url
    |> String.replace("https://github.com/", "")
    |> String.replace("http://github.com/", "")
  end

  defp api_get!(path) when is_binary(path) do
    url = "https://www.cryptocompare.com/api/data/#{path}"

    HTTPoison.get!(url).body
    |> Poison.decode!
    |> get_in(["Data"])
  end

  defp min_api_get!(path) when is_binary(path) do
    url = "https://min-api.cryptocompare.com/data/#{path}"

    HTTPoison.get!(url).body
    |> Poison.decode!
    |> get_in(["Data"])
  end
end
