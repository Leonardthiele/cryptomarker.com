defmodule SimpleForm do
  @moduledoc false
  @style_module SimpleForm.FormInputs
  @inferrer_module SimpleForm.TypeInferrer
  use Phoenix.HTML

  defdelegate label_translation(f, name), to: SimpleForm.FormInputs

  def error_notification(changeset) do
    if changeset.action do
      @style_module.error_notification(changeset)
    end
  end

  def input(f, name, opts \\ []) do
    type = @inferrer_module.run(f, name, opts)
    @style_module.input(type, f, name, opts)
  end

  def submit_button(content, opts \\ []) do
    [
      content_tag(:"button", content, opts ++ [type: "submit"]),
    ]
  end
end
