defmodule Platform.Repo do
  use Ecto.Repo, otp_app: :platform
  use Scrivener, page_size: 100

  @doc """
  Dynamically loads the repository url from the
  DATABASE_URL environment variable.
  """
  def init(_, opts) do
    {:ok, Keyword.put(opts, :url, System.get_env("DATABASE_URL"))}
  end

  def toggle(%{__struct__: _} = data, field) when is_atom(field) do
    old_value = Map.get(data, field)
    update_map = Map.put(%{}, field, !old_value)

    data
    |> Ecto.Changeset.change(update_map)
    |> update()
  end
end
