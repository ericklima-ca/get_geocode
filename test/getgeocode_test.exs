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

  test "get/1 returning 'No result' return from nominatim" do
    error = get("asdasdasd asdasdasd")
    assert error == {:ok, "No result"}
  end

  test "get/1 returning error from viacep with CEP invalid" do
    error = get("12345678")
    assert error == {:error, "Invalid input"}
  end

  test "get/1 returning error 'cause the input is neither cep nor the address " do
    error = get("asdasdasdasdasdasdasdasdasd")
    assert error == {:error, "Invalid input"}
  end

  test "get/1 with a tuple" do
    result = get({-3.0999329, -60.0552931})
    assert {:ok, _} = result
  end
end
