defmodule Platform.Application do
  @moduledoc false
  use Application

  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      supervisor(Platform.Repo, []),
      supervisor(PlatformWeb.Endpoint, [])
    ]

    schedulers = [
      worker(Platform.Core.Scheduler, []),
      worker(Platform.Social.Scheduler, [])
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Platform.Supervisor]
    if System.get_env("CRONJOBS_ENABLED") do
      Supervisor.start_link(children ++ schedulers, opts)
    else
      Supervisor.start_link(children, opts)
    end
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    PlatformWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
