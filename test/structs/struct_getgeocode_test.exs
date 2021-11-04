defmodule StructGetGeocodeTest do
  @moduledoc """
  ## TODO
  """
  use ExUnit.Case, async: true

  test "init struct Geocode" do
    struct_geocode = %GetGeocode.Geocode{}
    assert Map.has_key?(struct_geocode, :postalcode)
  end
end
