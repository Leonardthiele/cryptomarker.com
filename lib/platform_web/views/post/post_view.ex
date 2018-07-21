defmodule PlatformWeb.PostView do
  alias Platform.CMS.Schema.Post
  use PlatformWeb, :view

  def page("index.html", conn), do: %{
    title: "Posts",
    path: post_path(conn, :index)
  }
  def page("new.html", conn), do: %{
    parent: page("index.html", conn),
    title: "New post"
  }
  def page("show.html", conn), do: %{
    parent: page("index.html", conn),
    title: "#{conn.assigns.post.title}"
  }
  def page("edit.html", conn), do: %{
    parent: page("index.html", conn),
    title: "Edit post"
  }

  def as_html(txt) do
    txt
    |> Earmark.as_html!
    |> raw
  end
end
