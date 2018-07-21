defmodule Credo.Check.Phoenix.ControllerContext do
  @moduledoc """
  A controller in Phoenix shouldn't use Repo directly.
  """
  @explanation [check: @moduledoc]

  use Credo.Check, base_priority: :low

  alias Credo.Code.Module

  @doc false
  def run(%SourceFile{filename: filename} = source_file, params \\ []) do
    if Path.extname(filename) == ".exs" do
      []
    else
      issue_meta = IssueMeta.for(source_file, params)

      {_continue, issues} = Credo.Code.prewalk(source_file, &traverse(&1, &2, issue_meta), {true, []})

      issues
    end
  end

  # Private functions
  defp traverse({:defmodule, _meta, _arguments} = ast, {true, issues}, issue_meta) do
    mod_name = Module.name(ast)
    if CodeHelper.matches?(mod_name, ~r/(\.\w+Controller)$/) do
      new_issues = Credo.Code.prewalk(ast, &find_issues(&1, &2, issue_meta))

      {ast, {true, issues ++ new_issues}}
    else
      {ast, {false, issues}}
    end
  end
  defp traverse(ast, {continue, issues}, _issue_meta) do
    {ast, {continue, issues}}
  end

  defp find_issues({:., _, [{:__aliases__, meta, [:Repo]}, _fn_name]} = ast, issues, issue_meta) do
    trigger = ""
    {ast, issues ++ [issue_for(issue_meta, meta[:line], trigger)]}
  end
  defp find_issues(ast, issues, _issue_meta) do
    {ast, issues}
  end

  defp issue_for(issue_meta, line_no, trigger) do
    format_issue issue_meta,
      message: "Should not use Repo in Controller directly. Use a context.",
      trigger: trigger,
      line_no: line_no
  end
end
