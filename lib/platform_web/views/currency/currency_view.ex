defmodule PlatformWeb.CurrencyView do
  alias Platform.Core.CurrencyLogoUploader
  alias PlatformWeb.Core.Schema.Candle
  use PlatformWeb, :view

  # Page Configuration
  def page("index.html", conn), do: %{
    title: "Currencies #{currencies_count(conn)}",
    path: currency_path(conn, :index),
    no_header: true
  }
  def page("show.html", conn), do: %{
    parent: page("index.html", conn),
    title: "#{conn.assigns.currency.name} (#{conn.assigns.currency.symbol})",
    path: currency_path(conn, :show, conn.assigns.currency),
    no_header: true
  }
  def page("new.html", conn), do: %{
    parent: page("index.html", conn),
    title: "New currency"
  }
  def page("edit.html", conn), do: %{
    parent: page("show.html", conn),
    title: "Edit currency",
    path: currency_path(conn, :edit, conn.assigns.currency)
  }

  # View functions
  def currencies_count(%{assigns: %{currencies: currencies}}), do: "(#{length(currencies)})"
  def currencies_count(_), do: ""

  def get_rating([]), do: nil
  def get_rating([currency_rating | _]) do
    currency_rating.rating
  end
  def get_rating(_), do: nil

  def get_rating_class(-2), do: "text-danger"
  def get_rating_class(-1), do: "text-muted"
  def get_rating_class(0),  do: "text-muted"
  def get_rating_class(1),  do: "text-success"
  def get_rating_class(2),  do: "text-warning"
  def get_rating_class(_),  do: "text-muted"

  def get_rating_th(-2), do: "table-scam"
  def get_rating_th(-1), do: "table-uninteresting"
  def get_rating_th(0),  do: ""
  def get_rating_th(1),  do: "table-favorite"
  def get_rating_th(2),  do: ""
  def get_rating_th(_),  do: ""

  def colorize_percentage(nil), do: ""
  def colorize_percentage(number) do
    cond do
      number  > 0 -> content_tag(:span, number_to_percentage(number, precision: 2), class: "text-success")
      number  < 0 -> content_tag(:span, number_to_percentage(number, precision: 2), class: "text-danger")
      number == 0 -> content_tag(:span, number_to_percentage(0, precision: 2))
    end
  end

  def colorize_progressbar(number) do
    cond do
      number < 0.3 -> "progress-bar bg-danger"
      number < 0.7 -> "progress-bar bg-warning"
      number >= 0.7 -> "progress-bar bg-success"
    end
  end

  def progressbar(number, label \\ "") when is_float(number) do
    content_tag(:div, class: "progress") do
      content_tag(:div, class: colorize_progressbar(number), role: "progressbar", style: "width: #{number_to_percentage(number * 100, precision: 0)}") do
        [number_to_percentage(number * 100, precision: 0), " ", label]
      end
    end
  end

  def colorize_class(number) when number > 0, do: "text-success"
  def colorize_class(number) when number < 0, do: "text-danger"
  def colorize_class(_), do: nil

  def currency_link_icon(%{type: "website"}), do: fa_icon("globe fa-fw text-muted")
  def currency_link_icon(%{type: "announcement"}), do: fa_icon("bullhorn fa-fw text-muted")
  def currency_link_icon(%{type: "article"}), do: fa_icon("file-text-o fa-fw text-muted")
  def currency_link_icon(%{type: "explorer"}), do: fa_icon("search fa-fw text-muted")
  def currency_link_icon(%{type: "forum"}), do: fa_icon("comments fa-fw text-muted")
  def currency_link_icon(%{type: "whitepaper"}), do: fa_icon("info-circle fa-fw text-muted")
  def currency_link_icon(%{type: "video"}), do: fa_icon("video-camera fa-fw text-muted")
  def currency_link_icon(_), do: "..."

  def sortable_link(%Plug.Conn{params: params} = conn, title, column, _opts \\ []) when is_atom(column) do
    new_params =
      if params["order"] == Atom.to_string(column) do
        if params["order_direction"] == "desc" do
          Map.drop(params, ["order_direction"])
        else
          Map.put(params, "order_direction", "desc")
        end
      else
        params
        |> Map.put("order", column)
        |> Map.drop(["order_direction"])
      end

    path = Phoenix.Controller.current_path(conn, new_params)

    link title, to: path
  end
end
