defmodule StructCoordsTest do
  use ExUnit.Case, async: true
  alias GetGeocode.Coords

  test "test coords struct instantiation" do
    struct = %Coords{}
    assert Map.get(struct, :lat) == nil
  end
end
