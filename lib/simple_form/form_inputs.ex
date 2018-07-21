defmodule SimpleForm.FormInputs do
  @moduledoc false
  use Phoenix.HTML
  import Phoenix.HTML.Tag

  def default_wrapper(f, name, opts, do: block) do
    content_tag :div, wrapper_html(opts, %{class: "form-group"}) do
      [
        label(f, name, label_text(f, name, opts), class: "control-label #{if opts[:required] do "required" end}"),
        block,
        hint(opts),
        error_tag(f, name)
      ]
    end
  end

  def hint(opts) do
    if opts[:hint] do
      content_tag(:small, opts[:hint], class: "text-muted")
    else
      {:safe, ""}
    end
  end

  def input(:text_input, f, name, opts) do
    default_wrapper(f, name, opts) do
      text_input(f, name, input_html(opts, %{class: "form-control"}))
    end
  end

  def input(:markdown_editor, f, name, opts) do
    default_wrapper(f, name, opts) do
      textarea(f, name, input_html(opts, %{class: "form-control code-mirror-markdown"}))
    end
  end

  def input(:prepend, f, name, opts) do
    default_wrapper(f, name, opts) do
      content_tag :div, class: "input-group" do
        [
          content_tag(:span, opts[:prepend_text], class: "input-group-addon"),
          text_input(f, name, input_html(opts, %{class: "form-control"}))
        ]
      end
    end
  end

  def input(:file_input, f, name, opts) do
    # content_tag :div, wrapper_html(opts, %{class: "form-group"}) do
    #   [
    #     label(f, name, label_translation(f, name), class: "control-file"),
    #     label(f, name, class: "custom-file") do
    #       [
    #         file_input(f, name, input_html(opts, %{class: "custom-file-input"})),
    #         content_tag(:span, "", class: "custom-file-control")
    #       ]
    #     end
    #   ]
    # end
    default_wrapper(f, name, opts) do
      file_input(f, name, input_html(opts, %{class: "form-control"}))
    end
  end

  def input(:number_input, f, name, opts) do
    default_wrapper(f, name, opts) do
      number_input(f, name, input_html(opts, %{class: "form-control"}))
    end
  end

  def input(:textarea, f, name, opts) do
    default_wrapper(f, name, opts) do
      textarea(f, name, input_html(opts, %{class: "form-control"}))
    end
  end

  def input(:select, f, name, opts) do
    default_wrapper(f, name, opts) do
      select(f, name, opts[:collection], input_html(opts, %{class: "form-control c-select", prompt: opts[:prompt]}))
    end
  end

  def input(:date_select, f, name, opts) do
    default_wrapper(f, name, opts) do
      content_tag :div do
        date_select(f, name)
      end
    end
  end

  def input(:checkbox, f, name, opts) do
    content_tag :div, wrapper_html(opts, %{class: "form-group"}) do
      [
        label(f, name, class: "custom-control custom-checkbox") do
          [
            checkbox(f, name, input_html(opts, %{class: "custom-control-input"})),
            content_tag(:span, "", class: "custom-control-indicator"),
            content_tag(:span, label_text(f, name, opts), class: "custom-control-description")
          ]
        end,
        error_tag(f, name)
      ]
    end
  end

  def input(unknown_type, _f, name, _opts) do
    raise "Cannot find input with type #{unknown_type} for field #{name}"
  end

  def translate_error({msg, opts}) do
    if opts[:count] do
      Gettext.dngettext(PlatformWeb.Gettext, "errors", msg, msg, opts[:count], opts)
    else
      Gettext.dgettext(PlatformWeb.Gettext, "errors", msg)
    end
  end

  def translate_error(msg) do
    Gettext.dgettext(PlatformWeb.Gettext, "errors", msg)
  end

  def error_tag(form, field) do
    if error = form.errors[field] do
      content_tag :span, translate_error(error), class: "help-block text-danger"
    else
      {:safe, ""}
    end
  end

  def error_notification(_changeset) do
    content_tag :div, class: "alert alert-danger" do
      content_tag :p, Gettext.dgettext(PlatformWeb.Gettext, "forms", "error_notification")
    end
  end

  def label_translation(f, name) do
    translation_key = "#{f.id}.#{name}.label"
    translation = Gettext.dgettext(PlatformWeb.Gettext, "forms", translation_key)
    if translation == translation_key do
      default_translation_key = "defaults.#{name}.label"
      default_translation = Gettext.dgettext(PlatformWeb.Gettext, "forms", default_translation_key)
      if default_translation == default_translation_key do
        humanize(name)
      else
        default_translation
      end
    else
      translation
    end
  end

  # Private methods
  defp label_text(f, name, opts) do
    if opts[:label] do
      opts[:label]
    else
      label_translation(f, name)
    end
  end

  defp input_html(opts, defaults) do
    defaults |> Map.merge(opts[:input_html] || %{}) |> Map.to_list
  end

  defp wrapper_html(opts, defaults) do
    defaults |> Map.merge(opts[:wrapper_html] || %{}) |> Map.to_list
  end
end
