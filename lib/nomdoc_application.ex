defmodule NomdocApplication do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl Application
  def start(_type, _args) do
    children = [
      Nomdoc.Repo,
      NomdocWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:nomdoc, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Nomdoc.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Nomdoc.Finch},
      # Start a worker by calling: Nomdoc.Worker.start_link(arg)
      # {Nomdoc.Worker, arg},
      {Oban, Application.fetch_env!(:nomdoc, Oban)},
      Nomdoc.CloudflareAccessAuth.Jwks,
      Nomdoc.GoogleOAuth.Jwks,
      # Start to serve requests, typically the last entry
      NomdocWeb.Endpoint,
      ConsoleWeb.Endpoint,
      WorkspaceWeb.Endpoint,
      HealthcareWeb.Endpoint,
      NomdocProxy
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Nomdoc.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl Application
  def config_change(changed, _new, removed) do
    NomdocWeb.Endpoint.config_change(changed, removed)
    ConsoleWeb.Endpoint.config_change(changed, removed)
    WorkspaceWeb.Endpoint.config_change(changed, removed)
    HealthcareWeb.Endpoint.config_change(changed, removed)

    :ok
  end
end
