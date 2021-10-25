defmodule GetGeocodeGeocodeTest do
  use ExUnit.Case, async: true

  test "create Geocode struct" do
    geocode = %GetGeocode.Geocode{}
    assert Map.has_key?(geocode, :full_details)
  end

  test "construct/2" do
    struct_geocode =
      [1, 2, 3, 4, 5, 6, 7, 8]
      |> GetGeocode.Geocode.constructor()

    assert Map.get(struct_geocode, :postalcode)
  end
end
