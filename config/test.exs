use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :platform, PlatformWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :platform, Platform.Repo,
  adapter: Ecto.Adapters.MySQL,
  charset: "utf8mb4",
  username: System.get_env("DATABASE_MYSQL_USERNAME") || "root",
  password: System.get_env("DATABASE_MYSQL_PASSWORD") || "",
  database: "cryptomarker_test",
  hostname: "127.0.0.1",
  pool: Ecto.Adapters.SQL.Sandbox

config :goth,
  json: File.read!("config/gcs-key-test.json")

config :exvcr,
  vcr_cassette_library_dir: "test/support/vcr_cassettes"
