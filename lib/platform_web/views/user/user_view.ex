defmodule PlatformWeb.UserView do
  use PlatformWeb, :view

  def page("index.html", conn), do: %{
    title: "Users",
    path: user_path(conn, :index)
  }
  def page("show.html", conn), do: %{
    parent: page("index.html", conn),
    title: "#{conn.assigns.user.name}",
    path: user_path(conn, :show, conn.assigns.user)
  }
  def page("edit.html", conn), do: %{
    parent: page("show.html", conn),
    title: "Edit user"
  }
end
