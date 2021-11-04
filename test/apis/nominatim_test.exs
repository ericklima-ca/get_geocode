defmodule GetGeocodeApisNominatimTest do
  use ExUnit.Case, async: true
  alias GetGeocode.Apis.Nominatim

  setup do
    %{
      addr: "Rua Izaurina Braga, Compensa, Manaus",
      coords: {-3.0999329, -60.0552931}
    }
  end

  test "test get_data/1 result against lat, lon from response", %{addr: addr} do
    result = Nominatim.get_data(addr)
    assert Map.has_key?(result, "lon")
  end

  test "test get_data/1 against input being tuple with lat, lng", %{coords: coords} do
    result = Nominatim.get_data(coords)
    assert Map.has_key?(result, "lat")
    assert Map.has_key?(result, "lon")
  end
end
