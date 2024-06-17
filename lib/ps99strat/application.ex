defmodule Ps99strat.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Ps99stratWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:ps99strat, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Ps99strat.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Ps99strat.Finch},
      # Start a worker by calling: Ps99strat.Worker.start_link(arg)
      # {Ps99strat.Worker, arg},
      # Start to serve requests, typically the last entry
      Ps99stratWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Ps99strat.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    Ps99stratWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
