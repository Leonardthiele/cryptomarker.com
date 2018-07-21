defmodule PlatformWeb.ConnCaseLogins do
  @moduledoc """
  Logins
  """
  alias Platform.Factory
  use Phoenix.ConnTest

  def login_as_user(%{conn: conn}) do
    current_user = Factory.insert(:user)
    conn = assign(conn, :current_user, current_user)
    [conn: conn, current_user: current_user]
  end

  def login_as_moderator(%{conn: conn}) do
    current_user = Factory.insert(:user, moderator: true)
    conn = assign(conn, :current_user, current_user)
    [conn: conn, current_user: current_user]
  end

  def login_as_admin(%{conn: conn}) do
    current_user = Factory.insert(:user, admin: true)
    conn = assign(conn, :current_user, current_user)
    [conn: conn, current_user: current_user]
  end
end
