defmodule GetGeocode.Cache do
  use GenServer

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_call({:get, geocode}, _from, state) do
    result = Map.get(state, geocode.street)
    {:reply, result, state}
  end

  @impl true
  def handle_call(:get_all, _from, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_cast({:post, geocode}, state) do
    case Map.has_key?(state, geocode.street) do
      true -> {:noreply, state}
      _ -> {:noreply, Map.put(state, geocode.street, geocode)}
    end
  end

  def start_link() do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def post(geocode) do
    GenServer.cast(__MODULE__, {:post, geocode})
  end

  def get(geocode) do
    GenServer.call(__MODULE__, {:get, geocode})
  end

  def get_all() do
    GenServer.call(__MODULE__, :get_all)
  end
end
