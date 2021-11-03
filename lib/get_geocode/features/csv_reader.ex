defmodule GetGeocode.Features.CSV do
  @moduledoc """
  In development... 
  Feature to read geodata from csv file.
  """

  @doc false
  def read_from_csv(path, separator \\ ?;) do
    Path.expand(path)
    |> File.stream!()
    |> Stream.transform([], fn line, acc -> 
      {[line], acc} end)
    |> Enum.to_list()
  end
end
