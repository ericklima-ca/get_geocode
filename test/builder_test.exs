defmodule GetGeocodeBuilderTest do
  use ExUnit.Case, async: true
  import GetGeocode.Builder

  setup do
    %{cep: "69035350"}
  end

  test "get_geocode/2 from viacep", %{cep: cep} do
    result = get_geocode(cep)
    assert result =~ "postalcode"
  end

  test "get_geocode/2 from nominatim" do
    result = get_geocode("Rua Izaurina Braga")
    assert result =~ "lng"
  end

  test "get_geocode/2 returning error message" do
    error = get_geocode("?")
    assert error =~ Jason.encode!(%{msg: "Invalid input"})
  end

  test "get_geocode/2 returning error message in map format" do
    error = get_geocode("?", :map)
    assert is_map(error)
  end

  test "get_geocode/2 with map format", %{cep: cep} do
    values_map = get_geocode(cep, :map)
    assert is_map(values_map)
  end

  test "get_geocode/2 with invalid format", %{cep: cep} do
    values_map = get_geocode(cep, :foo)
    assert values_map =~ "Invalid format!"
  end
end
