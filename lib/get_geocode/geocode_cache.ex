defmodule GetGeocode.Cache do
  @moduledoc false
  use GenServer

  @doc false
  @impl true
  def init(state) do
    {:ok, state}
  end

  @doc false
  @impl true
  def handle_call({:get, street}, _from, state) do
    result = Map.get(state, street)
    {:reply, result, state}
  end

  @doc false
  @impl true
  def handle_call(:get_all, _from, state) do
    {:reply, state, state}
  end

  @doc false
  @impl true
  def handle_cast({:post, geocode}, state) do
    case Map.has_key?(state, geocode.street) do
      true -> {:noreply, state}
      _ -> {:noreply, Map.put(state, geocode.street, geocode)}
    end
  end

  @doc false
  def start_link(opts \\ %{}) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @doc false
  def post({_, geocode}) do
    GenServer.cast(__MODULE__, {:post, geocode})
  end

  @doc false
  def get(street) do
    GenServer.call(__MODULE__, {:get, street})
  end

  @doc false
  def get_all() do
    GenServer.call(__MODULE__, :get_all)
  end
end
