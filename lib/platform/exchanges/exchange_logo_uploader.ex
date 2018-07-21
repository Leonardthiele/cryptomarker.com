defmodule Platform.Exchanges.ExchangeLogoUploader do
  @moduledoc false
  use Arc.Definition
  use Arc.Ecto.Definition

  @acl :public_read
  def s3_object_headers(_version, {file, _scope}) do
    [
      {"Content-Type", Plug.MIME.path(file.file_name)},
      {"Cache-Control", "public, max-age=31536000"}
    ]
  end

  defp calculate_storage_dir(path) when is_binary(path) do
    if Application.get_env(:arc, :storage) == Arc.Storage.Local do
      project_root = Application.app_dir(:platform)
      "#{project_root}/priv/static/uploads#{path}"
    else
      "uploads#{path}"
    end
  end

  def filename(version, {_file, _scope}) do
    version
  end

  def storage_dir(_version, {_file, scope}) do
    calculate_storage_dir("/exchange/logo/#{scope.id}")
  end

  @versions [:original, :icon32x32, :icon64x64, :medium]
  @extension_whitelist ~w(.png .jpg .jpeg)

  def validate({file, _}) do
    file_extension = file.file_name |> Path.extname |> String.downcase
    Enum.member?(@extension_whitelist, file_extension)
  end

  def transform(:icon32x32, _) do
    {:convert, "-strip -thumbnail 32x32^ -gravity center -extent 32x32 -format png", :png}
  end

  def transform(:icon64x64, _) do
    {:convert, "-strip -thumbnail 64x64^ -gravity center -extent 64x64 -format png", :png}
  end

  def transform(:medium, _) do
    {:convert, "-strip -thumbnail 300x300^ -gravity center -format png", :png}
  end
end
