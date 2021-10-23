defmodule GetGeocodeApisNominatimTest do
  use ExUnit.Case, async: true
  alias GetGeocode.Apis.Nominatim

  setup do
    %{
      addr: "Rua Izaurina Braga, Compensa, Manaus"
    }
  end

  test "test get_data/1 result against lat, lon from response", %{addr: addr} do
    result = Nominatim.get_data(addr)
    assert Map.has_key?(result, "lon")
  end
end
