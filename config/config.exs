# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
import System, only: [get_env: 1]
use Mix.Config

# General application configuration
config :platform,
  ecto_repos: [Platform.Repo]

# Configures the endpoint
config :platform, PlatformWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "YkQo6f2v97cer+zzyPHb5g7+ejO0r7qV2TZHlqX9HF75IvUVD67jHi9ffxN2try3",
  render_errors: [view: PlatformWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Platform.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :scrivener_html,
  routes_helper: PlatformWeb.Router.Helpers,
  view_style: :bootstrap_v4

config :ueberauth, Ueberauth,
  providers: [
    github: {Ueberauth.Strategy.Github, [default_scope: "user:email"]}
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
