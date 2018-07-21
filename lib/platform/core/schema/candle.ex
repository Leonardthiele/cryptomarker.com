defmodule Platform.Core.Schema.Candle do
  @moduledoc """
  Saves the OHCLV for a currency. Currency 1m block
  """
  use Platform, :schema

  schema "candles" do
    field :currency_symbol, :string
    field :currency_to, :string
    field :time, :integer
    field :open, :float
    field :high, :float
    field :close, :float
    field :low, :float
    field :volume_from, :float
    field :volume_to, :float

    belongs_to :currency, Platform.Core.Schema.Currency
  end

  @doc false
  def changeset(%__MODULE__{} = model, attrs) do
    model
    |> cast(attrs, [:currency_symbol, :currency_to, :time, :open, :high, :low, :close, :volume_from, :volume_to])
    |> validate_required([:currency_symbol, :currency_to, :time, :open, :high, :low, :close, :volume_from, :volume_to])
  end
end
