defmodule GetGeocode.Cache do
  use GenServer

  @max 10

  def init(_) do
    :ets.new(__MODULE__, [
      :set,
      :public,
      :named_table,
      decentralized_counters: true
    ])

    {:ok, nil}
  end

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def set(key, value) do
    if count() >= @max do
      elems = :ets.tab2list(__MODULE__)

      {oldest_key, _} =
        Enum.reduce(elems, hd(elems), fn
          {key, {_value, timestamp}}, {_oldest_key, oldest_timestamp}
          when timestamp < oldest_timestamp ->
            {key, timestamp}

          _item, {oldest_key, oldest_timestamp} ->
            {oldest_key, oldest_timestamp}
        end)

      :ets.delete(__MODULE__, oldest_key)
    end

    :ets.insert(__MODULE__, {key, value, System.system_time()})
  end

  def get(key) do
    :ets.lookup(__MODULE__, key)
    |> List.first()
    |> case do
      nil ->
        nil

      t ->
        elem(t, 1)
    end
  end

  def clean do
    :ets.delete_all_objects(__MODULE__)
  end

  defp count do
    :ets.info(__MODULE__, :size)
  end
end
