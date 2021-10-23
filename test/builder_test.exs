defmodule GetGeocodeBuilderTest do
  use ExUnit.Case, async: true
  import GetGeocode.Builder

  @input_viacep "69035350"
  @input_nominatim "Rua Izaurina Braga, Compensa, Amazonas"

  test "get_geocode/1 from viacep" do
    result = get_geocode(@input_viacep)
    assert result =~ "postalcode"
  end

  test "get_geocode/1 from nominatim" do
    result = get_geocode(@input_nominatim)
    assert result =~ "lng"
  end

  test "get_geocode/1 returning error message" do
    error = get_geocode("?")
    assert error =~ Jason.encode!(%{msg: "Invalid input"})
  end
end
