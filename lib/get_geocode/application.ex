defmodule GetGeocode.Application do
  use Application

  def start(_type, _args) do
    children = [
      GetGeocode.Cache
    ]

    opts = [strategy: :one_for_one, name: GetGeocode.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
