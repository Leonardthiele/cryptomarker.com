defmodule Platform.Mixfile do
  use Mix.Project

  def project do
    [
      app: :platform,
      version: "0.0.1",
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix, :gettext] ++ Mix.compilers,
      start_permanent: Mix.env == :prod,
      aliases: aliases(),
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        "coveralls": :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test,
        "vcr": :test,
        "vcr.delete": :test,
        "vcr.check": :test,
        "vcr.show": :test
      ]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Platform.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:arc_ecto, "~> 0.7"},
      {:arc_gcs, "~> 0.0.3"},
      {:arc, "~> 0.8"},
      {:calendar, "~> 0.17.4"},
      {:canada, "~> 1.0.1"},
      {:cowboy, "~> 1.0"},
      {:credo, "~> 0.8", only: [:dev, :test]},
      {:crypto_exchanges, "~> 0.3"},
      {:earmark, "> 1.2.2"},
      {:ex_machina, "~> 2.1", only: :test},
      {:excoveralls, "~> 0.7", only: :test},
      {:extwitter, "~> 0.8"},
      {:exvcr, "~> 0.8", only: :test},
      {:gettext, "~> 0.11"},
      {:httpoison, ">= 0.0.0"},
      {:mariaex, "~> 0.8.1"},
      {:mix_test_watch, "~> 0.3", only: :dev},
      {:number, "~> 0.5.2"},
      {:phoenix_ecto, "~> 3.2"},
      {:phoenix_html, "~> 2.10"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix, "~> 1.3.0"},
      {:poison, ">= 0.0.0"},
      {:quantum, "~> 2.1.0"},
      {:scrivener_ecto, "~> 1.2"},
      {:scrivener_html, "~> 1.5"},
      {:scrivener, "~> 2.3.0"},
      {:tentacat, "~> 0.5"},
      {:ueberauth_github, "~> 0.4"},
      {:ueberauth, "~> 0.4"},
      {:websockex, "~> 0.4.0"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.load", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "test": ["ecto.create --quiet", "ecto.migrate", "test"],
      "phx.server": ["ecto.migrate", "phx.server"],
      "credo": ["credo --strict"],
      "s": ["phx.server"],
      "t": ["test.watch"],
    ]
  end
end
