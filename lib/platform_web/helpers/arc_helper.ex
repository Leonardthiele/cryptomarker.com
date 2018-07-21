defmodule PlatformWeb.ArcHelper do
  @moduledoc false
  use Phoenix.HTML

  @doc """
  iex> ArcHelper.upload_path("/test.jpg", Arc.Storage.Local)
  "/test.jpg"

  iex> ArcHelper.upload_path("/test.jpg", Arc.Storage.GCS)
  "/test.jpg"
  """
  def upload_path(path, storage_type \\ Application.get_env(:arc, :storage)) do
    if storage_type == Arc.Storage.Local do
      project_root = Application.app_dir(:platform)
      String.replace(path, "#{project_root}/priv/static", "")
    else
      path
    end
  end
end
