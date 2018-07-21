defmodule PlatformWeb do
  @moduledoc """
  The entrypoint for defining your web interface, such
  as controllers, views, channels and so on.

  This can be used in your application as:

      use PlatformWeb, :controller
      use PlatformWeb, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below. Instead, define any helper function in modules
  and import those modules here.
  """

  def controller do
    quote do
      use Phoenix.Controller, namespace: PlatformWeb
      import Plug.Conn
      import PlatformWeb.Router.Helpers
      import PlatformWeb.Gettext
      import PlatformWeb.CurrentUserPlug.Helpers
      import PlatformWeb.CanHelper
    end
  end

  def view do
    quote do
      use Phoenix.View, root: "lib/platform_web/views",
                        namespace: PlatformWeb

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_flash: 2, view_module: 1]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML
      use Number

      import PlatformWeb.Router.Helpers
      import PlatformWeb.ErrorHelpers
      import PlatformWeb.Gettext
      import PlatformWeb.TabsFilterHelper
      import PlatformWeb.DebugHelper
      import PlatformWeb.AutoLinkHelper
      import PlatformWeb.DropdownHelper
      import PlatformWeb.IconHelper
      import PlatformWeb.ArcHelper
      import PlatformWeb.CurrentUserPlug.Helpers
      import PlatformWeb.CanHelper
      import SimpleForm
    end
  end

  def router do
    quote do
      use Phoenix.Router
      import Plug.Conn
      import Phoenix.Controller
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import PlatformWeb.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
