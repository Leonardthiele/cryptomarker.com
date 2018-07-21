defmodule Platform.Core.CurrencyLogoUpdater do
  @moduledoc """
  Tries to fetch a logo from CryptoCompare for a currency.
  Search is by symbol
  """
  alias Platform.Repo
  alias Platform.Core.Schema.Currency
  require Ecto.Query
  require Logger

  def update_all do
    Logger.info("Updating currencies logos")

    currencies_with_github_repo =
      Currency
      |> Ecto.Query.where([c], is_nil(c.logo))
      |> Ecto.Query.order_by([desc: :id])
      |> Repo.all()

    Enum.each currencies_with_github_repo, &update(&1)
  end

  def update(%Currency{symbol: symbol} = currency) do
    if url = get_coinlist_url(symbol) do
      upload_from_url(currency, url)
      :timer.sleep(200)
    end
  end

  # Private functions
  defp get_coinlist_url(symbol) do
    path =
      HTTPoison.get!("https://www.cryptocompare.com/api/data/coinlist/").body
      |> Poison.decode!
      |> get_in(["Data", symbol, "ImageUrl"])

    if path do
      "https://www.cryptocompare.com#{path}"
    else
      nil
    end
  end

  defp upload_from_url(currency, url) do
    {:ok, filename} = Platform.Core.CurrencyLogoUploader.store({url, currency})
    name_with_ts = "#{filename}?63671430450"
    Ecto.Adapters.SQL.query(Repo, "UPDATE currencies SET logo = '#{name_with_ts}' where id = #{currency.id}")
  end
end
