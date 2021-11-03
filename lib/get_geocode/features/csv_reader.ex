defmodule GetGeocode.Features.CSV do
  @moduledoc """
  In development... 
  Feature to read geodata from csv file.
  """
  NimbleCSV.define(CSVReader, separator: ";")
  @doc false
  def read_from_csv(
        path,
        skip_headers \\ false
      ) do
    Path.expand(path)
    |> File.stream!()
    |> CSVReader.parse_stream(skip_headers: skip_headers)
    |> Stream.map(fn x -> Enum.at(x, 12) end) # TO DO: make index '12' dynamic
    |> Enum.to_list()
  end
end
