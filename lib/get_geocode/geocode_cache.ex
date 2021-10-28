# TO BE IMPLEMENTED !!!
# defmodule GetGeocodeCash do
#   use GenServer

#   def init(state) do
#     {:ok, state}
#   end

#   def handle_cast({:store, new_data}, _state) do
#     {:noreply, new_data}
#   end

#   def handle_call({:get, cep}, _from, data) do
#     result = Map.get(data, cep)
#     {:reply, result, data}
#   end

#   def start_link(state \\ []) do
#     GenServer.start_link(__MODULE__, state, name: __MODULE__)
#   end

#   def store(new_data) do
#     GenServer.cast(__MODULE__, {:store, new_data})
#   end

#   def get(cep) do
#     GenServer.call(__MODULE__, {:get, cep})
#   end
# end
