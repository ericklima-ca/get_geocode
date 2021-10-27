defmodule GetGeocodeTest do
  use ExUnit.Case, async: true
  import GetGeocode

  test "get/1 from viacep" do
    {_, result} = get("69030000")
    assert result.street == "Rua Izaurina Braga"
  end

  test "get/1 from nominatim" do
    {_, result} = get("Rua Izaurina Braga")
    assert result.postalcode == "69000-000"
  end

  test "get/1 returning error message" do
    error = get(1)
    assert error == {:error, "Invalid input"}
  end
  test "get/0 returning error message in no input suplied" do
    error = get()
    assert error == {:error, "Invalid input"}
  end
end
