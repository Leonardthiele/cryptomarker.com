defmodule PlatformWeb.TabsFilterHelper do
  @moduledoc """
  Helper to to build tabs which can change the paramter of a key.

  Example:
  tabs_filter(@conn, :view, [nil: "Anstehende", archive: "Vergangene", demo: "Demo"])
  """
  use Phoenix.HTML
  import Phoenix.Controller, only: [current_url: 2]

  def tabs_filter(conn, action, opts) do
    content_tag(:ul, class: "nav nav-pills nav-justified") do
      Enum.map opts, fn {value, title} ->
        tabs_filter_item(conn, action, value, title)
      end
    end
  end
  def tabs_filter(conn, action, opts, do: block) do
    content_tag(:ul, class: "nav nav-pills") do
      [
        Enum.map(opts, fn {value, title} ->
          tabs_filter_item(conn, action, value, title)
        end),
        block
      ]
    end
  end

  defp tabs_filter_item(conn, action, key, title) do
    condition =
      if key do
        conn.params[Atom.to_string(action)] == Atom.to_string(key)
      else
        conn.params[Atom.to_string(action)] == nil
      end

    map =
      if key do
        Map.put(%{}, action, key)
      else
        %{}
      end

    content_tag(:li, class: "nav-item") do
      link(title, to: current_url(conn, map), class: "nav-link #{if condition, do: "active"}")
    end
  end
end
