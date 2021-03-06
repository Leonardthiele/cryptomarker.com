use Mix.Config
import System, only: [get_env: 1]
require Logger

# For production, we often load configuration from external
# sources, such as your system environment. For this reason,
# you won't find the :http configuration below, but set inside
# PlatformWeb.Endpoint.init/2 when load_from_system_env is
# true. Any dynamic configuration should be done there.
#
# Don't forget to configure the url host to something meaningful,
# Phoenix uses this information when generating URLs.
#
# Finally, we also include the path to a cache manifest
# containing the digested version of static files. This
# manifest is generated by the mix phx.digest task
# which you typically run after static files are built.
config :platform, PlatformWeb.Endpoint,
  http: [port: get_env("PORT") || 80],
  debug_errors: if(get_env("DEBUG_ERRORS") == "true", do: true, else: false),
  url: [
    scheme: get_env("PROJECT_URL_SCHEME") || "http",
    host: get_env("PROJECT_URL_HOST") || "example.com",
    port: get_env("PROJECT_URL_PORT") || get_env("PORT") || 80
  ],
  secret_key_base: get_env("SECRET_KEY_BASE") || Logger.info("Please set env variable SECRET_KEY_BASE"),
  cache_static_manifest: "priv/static/cache_manifest.json",
  check_origin: false,
  server: true,
  noindex: if(get_env("NOINDEX") == "true", do: true, else: false)

# Do not print debug messages in production
config :logger, level: :info

config :platform, Platform.Repo,
  adapter: Ecto.Adapters.MySQL,
  username: get_env("DATABASE_MYSQL_USERNAME") || "root",
  password: get_env("DATABASE_MYSQL_PASSWORD") || "",
  database: get_env("DATABASE_MYSQL_DATABASE") || "coinex_prod",
  hostname: get_env("DATABASE_MYSQL_HOSTNAME") || "localhost",
  pool_size: get_env("DATABASE_MYSQL_POOLSIZE") || 20,
  pool_timeout: 15_000

config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: get_env("GITHUB_CLIENT_ID"),
  client_secret: get_env("GITHUB_CLIENT_SECRET")

  # Arc (Uploader)
config :arc,
  storage: Arc.Storage.GCS,
  bucket: get_env("PROJECT_ARC_BUCKET") || Logger.info("Please set env variable PROJECT_ARC_BUCKET")

# Google Cloud authentication
config :goth,
  json: File.read!("config/gcs-key-prod.json")


# ## SSL Support
#
# To get SSL working, you will need to add the `https` key
# to the previous section and set your `:url` port to 443:
#
#     config :platform, PlatformWeb.Endpoint,
#       ...
#       url: [host: "example.com", port: 443],
#       https: [:inet6,
#               port: 443,
#               keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
#               certfile: System.get_env("SOME_APP_SSL_CERT_PATH")]
#
# Where those two env variables return an absolute path to
# the key and cert in disk or a relative path inside priv,
# for example "priv/ssl/server.key".
#
# We also recommend setting `force_ssl`, ensuring no data is
# ever sent via http, always redirecting to https:
#
#     config :platform, PlatformWeb.Endpoint,
#       force_ssl: [hsts: true]
#
# Check `Plug.SSL` for all available options in `force_ssl`.

# ## Using releases
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start the server for all endpoints:
#
#     config :phoenix, :serve_endpoints, true
#
# Alternatively, you can configure exactly which server to
# start per endpoint:
#
#     config :platform, PlatformWeb.Endpoint, server: true
#

# Finally import the config/prod.secret.exs
# which should be versioned separately.
# import_config "prod.secret.exs"
