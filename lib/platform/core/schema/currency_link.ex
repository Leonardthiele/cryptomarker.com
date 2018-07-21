defmodule Platform.Core.Schema.CurrencyLink do
  @moduledoc """
  Links belonging to a currency. The type can be e.g.:
  Website, Article, Whitepaper, ...
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "currency_links" do
    field :type, :string
    field :title, :string
    field :url, :string
    field :not_found, :boolean
    field :user_id, :integer
    timestamps()

    belongs_to :currency, Platform.Core.Schema.Currency
  end

  @doc false
  @fields [:type, :user_id, :title, :url, :not_found]
  def changeset(%__MODULE__{} = model, attrs) do
    model
    |> cast(attrs, @fields)
    |> validate_required([:type])
    |> validate_required_type_unless_not_found()
  end

  defp validate_required_type_unless_not_found(changeset) do
    if get_field(changeset, :not_found) do
      changeset
    else
      changeset
      |> validate_required([:url])
    end
  end

  def types do
    [
      "Website": "website",
      "Article": "article",
      "Announcement": "announcement",
      "Explorer": "explorer",
      "Forum": "forum",
      "Whitepaper": "whitepaper",
      "Video": "video"
    ]
  end
end
