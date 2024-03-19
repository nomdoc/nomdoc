defmodule Nomdoc.MixProject do
  use Mix.Project

  def project do
    [
      app: :nomdoc,
      version: "0.1.0",
      elixir: "~> 1.14",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {NomdocApplication, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:dns_cluster, "0.1.2"},
      {:dotenvy, "0.8.0"},
      {:ecto_enum, "1.4.0"},
      {:ecto_sql, "3.11.1"},
      {:finch, "0.17.0"},
      {:geo_postgis, "3.5.0"},
      {:gettext, "0.24.0"},
      {:jason, "1.4.1"},
      {:joken, "2.6.0"},
      {:joken_jwks, "1.6.0"},
      {:main_proxy, "0.3.1"},
      {:maybe, "1.0.0"},
      {:oban, "2.17.2"},
      {:phoenix, "1.7.10"},
      {:phoenix_ecto, "4.4.3"},
      {:phoenix_html, "4.0.0"},
      {:phoenix_live_dashboard, "0.8.3"},
      {:phoenix_live_view, "0.20.3"},
      {:plug_cowboy, "2.6.1"},
      {:postgrex, "0.17.4"},
      {:remote_ip, "1.1.0"},
      {:req, "0.4.13"},
      {:swoosh, "1.14.4"},
      {:telemetry_metrics, "0.6.2"},
      {:telemetry_poller, "1.0.0"},
      {:typed_struct, "0.3.0"},
      {:uniq, "0.6.1"},

      # Dev or build libs
      {:credo, "1.7.3", only: [:dev, :test], runtime: false},
      {:ex_machina, "2.7.0", only: :test},
      {:faker, "0.18.0", only: :test},
      {:floki, "0.35.2", only: :test},
      {:phoenix_live_reload, "1.4.1", only: :dev},
      {:tailwind, "0.2.2", runtime: Mix.env() == :dev}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "ecto.setup", "assets.setup", "assets.build"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"],
      "assets.setup": ["tailwind.install --if-missing", "cmd yarn install"],
      "assets.build": ["tailwind default", "cmd --cd assets node build.js"],
      "assets.deploy": ["tailwind default --minify", "cmd --cd assets node build.js --deploy", "phx.digest"]
    ]
  end
end
