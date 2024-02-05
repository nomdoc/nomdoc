import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :nomdoc, Nomdoc.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "nomdoc_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

config :nomdoc, NomdocWeb.Endpoint, secret_key_base: "G0R3IANG/CBzpi2vlZrMgT4cWruSWsHzV9F1wv7gy+XR32wnxRmTQS8jAuAlXH1j"

config :nomdoc, ConsoleWeb.Endpoint, secret_key_base: "fNZCwJs8J3pLVbaYUdshBr7o4WJ0mx1jh/KUZcbDCLp57rYBGP2WiZW3TIGf3T46"

config :nomdoc, WorkspaceWeb.Endpoint,
  secret_key_base: "sbxGtWA2GkOYWsKFS59bx5QO73YebDn4csyUdBXiLg2tRM1oGOvxJsL7QW8vq3KK"

# In test we don't send emails.
config :nomdoc, Nomdoc.Mailer, adapter: Swoosh.Adapters.Test

# Prevent Oban from running jobs and plugins during test.
config :nomdoc, Oban, testing: :inline

# Configures Nomdoc proxy backends
config :nomdoc, NomdocProxy,
  backends: [
    %{
      # Matches www.nomdoc.net
      host: ~r/^www\.nomdoc\.net$/,
      phoenix_endpoint: NomdocWeb.Endpoint
    },
    %{
      # Matches console.nomdoc.net
      host: ~r/^console\.nomdoc\.net$/,
      phoenix_endpoint: ConsoleWeb.Endpoint
    },
    %{
      # Matches workspace.nomdoc.net
      host: ~r/^workspace\.nomdoc\.net$/,
      phoenix_endpoint: WorkspaceWeb.Endpoint
    }
  ]

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :main_proxy,
  http: [:inet6, ip: {127, 0, 0, 1}, port: 4002],
  server: false

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
