defmodule PlatformWeb.PageController do
  use PlatformWeb, :controller

  def index(conn, _params) do
    redirect conn, to: currency_path(conn, :index)
  end
end
