defmodule Platform.Exchanges.Schema.ExchangeCurrency do
  @moduledoc """
  A single currency which is traded at an exchange.
  """
  use Platform, :schema

  schema "exchange_currencies" do
    field :active, :boolean, default: true
    timestamps()

    belongs_to :currency, Platform.Core.Schema.Currency
    belongs_to :exchange, Platform.Exchanges.Schema.Exchange
  end

  @doc false
  def changeset(%__MODULE__{} = model, attrs) do
    model
    |> cast(attrs, [:currency_id, :active])
    |> validate_required([:currency_id, :active])
    |> unique_constraint(:currency_id, name: "exchange_currencies_exchange_id_currency_id_index")
  end
end
