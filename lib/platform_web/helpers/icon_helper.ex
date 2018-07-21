defmodule PlatformWeb.IconHelper do
  @moduledoc false
  use Phoenix.HTML

  @doc """
  iex> IconHelper.fa_icon("cert") |> safe_to_string()
  ~s(<i class="fa fa-cert"></i>)
  """
  def fa_icon(icon_name) when is_binary(icon_name) do
    content_tag :i, "", class: "fa fa-#{icon_name}"
  end

  @doc """
  iex> IconHelper.fa_icon("cert", "Certificate") |> safe_to_string()
  ~s(<i class="fa fa-cert"></i> Certificate)
  """
  def fa_icon(icon_name, title)  when is_binary(icon_name) and is_binary(title) do
    Phoenix.HTML.raw "<i class=\"fa fa-#{icon_name}\"></i> #{title}"
  end
end
