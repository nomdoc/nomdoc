# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :nomdoc,
  ecto_repos: [Nomdoc.Repo],
  generators: [timestamp_type: :utc_datetime, binary_id: true],
  environment: config_env()

# WARNING: Configure all endpoints to not start a server in order to avoid
# endpoints bypassing MainProxy.

# Endpoint for www.nomdoc.com
config :nomdoc, NomdocWeb.Endpoint,
  adapter: Phoenix.Endpoint.Cowboy2Adapter,
  render_errors: [
    formats: [html: NomdocWeb.ErrorHTML, json: NomdocWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Nomdoc.PubSub,
  live_view: [signing_salt: "N+jvNdeU3jzC5shYPgOvsQhhrrh0cZ/g095S+YCk5oYvedvw2rkrFKHmrXd5jctT"],
  server: false

# Endpoint for console.nomdoc.com
config :nomdoc, ConsoleWeb.Endpoint,
  adapter: Phoenix.Endpoint.Cowboy2Adapter,
  render_errors: [
    formats: [html: ConsoleWeb.ErrorHTML, json: ConsoleWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Nomdoc.PubSub,
  live_view: [signing_salt: "94z7N0iC3cVFmT/3f25ePX8SbHzef+HIpcwwcNUXgUg9nhHRbeAfVT8ZGF/Xltyq"],
  server: false

# Endpoint for workspace.nomdoc.com
config :nomdoc, WorkspaceWeb.Endpoint,
  adapter: Phoenix.Endpoint.Cowboy2Adapter,
  render_errors: [
    formats: [html: WorkspaceWeb.ErrorHTML, json: WorkspaceWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Nomdoc.PubSub,
  live_view: [signing_salt: "WgpRMeSiUl5LIwe4gmUOSIEtOxpFlYSaJx+PODFl1t7vu3AdjKMJIvPBCRuM2q8L"],
  server: false

# Endpoint for healthcare.nomdoc.com
config :nomdoc, HealthcareWeb.Endpoint,
  adapter: Phoenix.Endpoint.Cowboy2Adapter,
  render_errors: [
    formats: [html: HealthcareWeb.ErrorHTML, json: HealthcareWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Nomdoc.PubSub,
  live_view: [signing_salt: "yw4HVkv8AZu2Ury2wH5WxkmEVICjh15UNp2jw1S8LoyrouqdQc5vzMDbyHsGntyq"],
  server: false

# Configures www.nomdoc.com user auth
config :nomdoc, NomdocWeb.UserAuth, google_oauth_redirect_uri: "https://www.nomdoc.com/oauth/google"

# Configures workspace.nomdoc.com user auth
config :nomdoc, WorkspaceWeb.UserAuth, google_oauth_redirect_uri: "https://workspace.nomdoc.com/oauth/google"

# Configures healthcare.nomdoc.com user auth
config :nomdoc, HealthcareWeb.UserAuth, google_oauth_redirect_uri: "https://healthcare.nomdoc.com/oauth/google"

# Configures the Repo
config :nomdoc, Nomdoc.Repo,
  types: Nomdoc.Repo.PostgrexTypes,
  migration_primary_key: [name: :id, type: :binary_id]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :nomdoc, Nomdoc.Mailer, adapter: Swoosh.Adapters.Local

# Configures Cloudflare Access auth
config :nomdoc, Nomdoc.CloudflareAccessAuth,
  jwks_url: "https://nomdoc.cloudflareaccess.com/cdn-cgi/access/certs",
  jwt_validator: Nomdoc.CloudflareAccessAuth.DefaultJwtValidator,
  jwt_iss: "https://nomdoc.cloudflareaccess.com",
  jwt_aud: [
    "35889312e2ad1658fedfcb1369191fe4d647163c63116ef1bbdf14b4f2464772"
  ]

# Configures Google OAuth
config :nomdoc, Nomdoc.GoogleOAuth,
  adapter: Nomdoc.GoogleOAuth.HttpClient,
  jwks_url: "https://www.googleapis.com/oauth2/v3/certs",
  oauth_url: "https://accounts.google.com/o/oauth2/v2/auth",
  token_url: "https://oauth2.googleapis.com/token",
  id_token_validator: Nomdoc.GoogleOAuth.IdTokenDefaultValidator,
  id_token_iss: [
    "https://accounts.google.com",
    "accounts.google.com"
  ]

# Configures Oban
config :nomdoc, Oban,
  queues: [default: 10, mailers: 20],
  repo: Nomdoc.Repo

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.4.1",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/common.css
      --output=../priv/static/assets/common.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$metadata[$level] $message\n",
  metadata: [:remote_ip, :request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
