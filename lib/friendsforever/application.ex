defmodule Friendsforever.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      FriendsforeverWeb.Telemetry,
      Friendsforever.Repo,
      {DNSCluster, query: Application.get_env(:friendsforever, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Friendsforever.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Friendsforever.Finch},
      # Start a worker by calling: Friendsforever.Worker.start_link(arg)
      # {Friendsforever.Worker, arg},
      # Start to serve requests, typically the last entry
      FriendsforeverWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Friendsforever.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    FriendsforeverWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
