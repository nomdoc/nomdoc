import Config
import Dotenvy

source([".env", System.get_env()])

# config/runtime.exs is executed for all environments, including
# during releases. It is executed after compilation and before the
# system starts, so it is typically used to load production configuration
# and secrets from environment variables or elsewhere. Do not define
# any compile-time configuration in here, as it won't be applied.
# The block below contains prod specific runtime configuration.

# ## Using releases
#
# If you use `mix release`, you need to explicitly enable the server
# by passing the PHX_SERVER=true when you start it:
#
#     PHX_SERVER=true bin/nomdoc start
#
# Alternatively, you can use `mix phx.gen.release` to generate a `bin/server`
# script that automatically sets the env var above.
if env!("PHX_SERVER", :boolean, nil) do
  config :main_proxy, server: true
end

if config_env() == :prod do
  port = env!("PORT", :integer!)
  # The secret key base is used to sign/encrypt cookies and other secrets.
  # A default value is used in config/dev.exs and config/test.exs but you
  # want to use a different value for prod and you most likely don't want
  # to check this value into version control, so we use an environment
  # variable instead.
  secret_key_base = env!("SECRET_KEY_BASE", :string!)
  database_url = env!("DATABASE_URL", :string!)
  ecto_ipv6 = env!("ECTO_IPV6", :boolean, nil)

  maybe_ipv6 = if ecto_ipv6, do: [:inet6], else: []

  config :nomdoc, Nomdoc.Repo,
    # ssl: true,
    url: database_url,
    prepare: :unnamed,
    socket_options: maybe_ipv6

  config :nomdoc, :dns_cluster_query, System.get_env("DNS_CLUSTER_QUERY")

  config :nomdoc, NomdocWeb.Endpoint,
    url: [host: "www.nomdoc.com"],
    secret_key_base: secret_key_base

  config :nomdoc, ConsoleWeb.Endpoint,
    url: [host: "console.nomdoc.com"],
    secret_key_base: secret_key_base

  config :nomdoc, WorkspaceWeb.Endpoint,
    url: [host: "workspace.nomdoc.com"],
    secret_key_base: secret_key_base

  config :main_proxy,
    http: [
      # Enable IPv6 and bind on all interfaces.
      # Set it to  {0, 0, 0, 0, 0, 0, 0, 1} for local network only access.
      # See the documentation on https://hexdocs.pm/plug_cowboy/Plug.Cowboy.html
      # for details about using IPv6 vs IPv4 and loopback vs public addresses.
      ip: {0, 0, 0, 0, 0, 0, 0, 0},
      port: port
    ]

  # ## SSL Support
  #
  # To get SSL working, you will need to add the `https` key
  # to your endpoint configuration:
  #
  #     config :nomdoc, NomdocWeb.Endpoint,
  #       https: [
  #         ...,
  #         port: 443,
  #         cipher_suite: :strong,
  #         keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
  #         certfile: System.get_env("SOME_APP_SSL_CERT_PATH")
  #       ]
  #
  # The `cipher_suite` is set to `:strong` to support only the
  # latest and more secure SSL ciphers. This means old browsers
  # and clients may not be supported. You can set it to
  # `:compatible` for wider support.
  #
  # `:keyfile` and `:certfile` expect an absolute path to the key
  # and cert in disk or a relative path inside priv, for example
  # "priv/ssl/server.key". For all supported SSL configuration
  # options, see https://hexdocs.pm/plug/Plug.SSL.html#configure/1
  #
  # We also recommend setting `force_ssl` in your endpoint, ensuring
  # no data is ever sent via http, always redirecting to https:
  #
  #     config :nomdoc, NomdocWeb.Endpoint,
  #       force_ssl: [hsts: true]
  #
  # Check `Plug.SSL` for all available options in `force_ssl`.

  # ## Configuring the mailer
  #
  # In production you need to configure the mailer to use a different adapter.
  # Also, you may need to configure the Swoosh API client of your choice if you
  # are not using SMTP. Here is an example of the configuration:
  #
  #     config :nomdoc, Nomdoc.Mailer,
  #       adapter: Swoosh.Adapters.Mailgun,
  #       api_key: System.get_env("MAILGUN_API_KEY"),
  #       domain: System.get_env("MAILGUN_DOMAIN")
  #
  # For this example you need include a HTTP client required by Swoosh API client.
  # Swoosh supports Hackney and Finch out of the box:
  #
  #     config :swoosh, :api_client, Swoosh.ApiClient.Hackney
  #
  # See https://hexdocs.pm/swoosh/Swoosh.html#module-installation for details.
end

config :nomdoc, Nomdoc.GoogleOAuth,
  client_id: env!("GOOGLE_OAUTH_CLIENT_ID", :string!),
  client_secret: env!("GOOGLE_OAUTH_CLIENT_SECRET", :string!)
