defmodule GetGeocode.Cache do
  use GenServer

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_call({:get, street}, _from, state) do
    result = Map.get(state, street)
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

  def start_link(opts \\ %{}) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def post({_, geocode}) do
    GenServer.cast(__MODULE__, {:post, geocode})
  end

  def get(street) do
    GenServer.call(__MODULE__, {:get, street})
  end

  def get_all() do
    GenServer.call(__MODULE__, :get_all)
  end
end
