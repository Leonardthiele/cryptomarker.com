defmodule PlatformWeb.Api.CurrencyView do
  use PlatformWeb, :view

  alias Platform.Core.CurrencyLogoUploader

  def render("index.json", %{currencies: currencies}) do
    Enum.map currencies, &currency_json(&1)
  end

  def currency_json(%{id: id, name: name, symbol: symbol} = currency) do
    logo_url = CurrencyLogoUploader.url({currency.logo, currency}, :icon32x32)
    %{
      id: id,
      name: "#{name} (#{symbol})",
      logo: upload_path(logo_url || "")
    }
  end
end
