defmodule WorkspaceWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :nomdoc

  # If a cookie's name begins with "__Host-", the cookie MUST be:
  #
  #   1. Set with a "Secure" attribute
  #
  #   2. Set from a URI whose "scheme" is considered "secure" by the user agent.
  #
  #   3. Sent only to the host which set the cookie.  That is, a cookie named
  #      "__Host-cookie1" set from "https://example.com" MUST NOT contain a
  #      "Domain" attribute (and will therefore be sent only to "example.com",
  #      and not to "subdomain.example.com").
  #
  #   4. Sent to every request for a host.  That is, a cookie named
  #      "__Host-cookie1" MUST contain a "Path" attribute with a value of "/".
  #
  # For more info, see
  # https://datatracker.ietf.org/doc/html/draft-west-cookie-prefixes-05#section-3.2
  #
  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  #
  # See https://hexdocs.pm/plug/1.14.2/Plug.Session.html#module-options and
  # https://hexdocs.pm/plug/1.14.2/Plug.Session.COOKIE.html#module-options for
  # more options.
  @session_options [
    store: :cookie,
    signing_salt: "hSVuVW+TcyUDnurAv6U5TEZ/j1n1NMv2BG+nkXE53lePjNkgoShzanxbC4dLa4vS",
    key: "__Host-SESSION",
    path: "/",
    http_only: true,
    secure: true,
    same_site: "Strict"
  ]

  socket "/live", Phoenix.LiveView.Socket, websocket: [connect_info: [session: @session_options]]

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phx.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/",
    from: :nomdoc,
    gzip: false,
    only: WorkspaceWeb.static_paths()

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
    plug Phoenix.Ecto.CheckRepoStatus, otp_app: :nomdoc
  end

  plug Phoenix.LiveDashboard.RequestLogger,
    param_key: "workspace_request_logger",
    cookie_key: "workspace_request_logger"

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  plug Plug.Session, @session_options
  plug RemoteIp
  plug WorkspaceWeb.Router
end
