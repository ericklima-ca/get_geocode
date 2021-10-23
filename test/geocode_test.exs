defmodule GetGeocodeGeocodeTest do
  use ExUnit.Case, async: true

  test "create Geocode struct" do
    geocode = %GetGeocode.Geocode{}
    assert Map.has_key?(geocode, :full_details)
  end
end
