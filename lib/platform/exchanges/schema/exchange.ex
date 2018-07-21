defmodule Platform.Exchanges.Schema.Exchange do
  @moduledoc """
  Schema for an exchange. Examples are Bittrex or Poloniex.
  Currencies for an exchange are in a separate schema.
  """
  use Platform, :schema
  use Arc.Ecto.Schema

  schema "exchanges" do
    field :name, :string
    field :logo, Platform.Exchanges.ExchangeLogoUploader.Type
    field :country, :string
    field :website_url, :string
    field :auto_managed, :boolean, default: false
    field :volume_usd, :float, default: 0.0
    timestamps()

    has_many :exchange_currencies, Platform.Exchanges.Schema.ExchangeCurrency, on_delete: :delete_all
  end

  @doc false
  @fields ~w(name country website_url volume_usd auto_managed)
  def changeset(%__MODULE__{} = model, attrs) do
    model
    |> cast(attrs, @fields)
    |> validate_required([:name, :country, :website_url, :auto_managed])
  end

  @file_fields ~w(logo)
  def file_changeset(%__MODULE__{} = model, params \\ %{}) do
    model
    |> cast_attachments(params, @file_fields)
  end
end
