defmodule Platform.CMS.Schema.Post do
  @moduledoc """
  Represents an post / article. Can be found at /posts.
  """
  use Platform, :schema

  @derive {Phoenix.Param, key: :slug}
  schema "posts" do
    field :content_markdown, :string
    field :description, :string
    field :header_image, :string
    field :published_at, :utc_datetime
    field :slug, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(%__MODULE__{} = model, attrs) do
    model
    |> cast(attrs, [:slug, :title, :description, :content_markdown, :header_image, :published_at])
    |> validate_required([:slug, :title, :description, :content_markdown])
    |> validate_format(:slug, ~r/^[a-z0-9\-]+$/, message: "Invalid characters! Please only use a-z, 0-9 and '-'.")
    |> unique_constraint(:slug)
    # |> add_error(:slug, "Invalid characters! Please only use a-z, 0-9 and '-'.")
  end
end
