defmodule PlatformWeb.DropdownHelper do
  @moduledoc false
  use Phoenix.HTML

  def dropdown_options(opts \\ [], do: block) do
    content_tag :div, class: "dropdown dropdown-options" do
      [
        content_tag(:a, opts[:icon] || "☰", data: [toggle: "dropdown"]),
        content_tag(:div, block, class: "dropdown-menu #{if opts[:right], do: "dropdown-menu-right"}")
      ]
    end
  end
end
