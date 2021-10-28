defmodule GetGeocodeApisViaCepTest do
  use ExUnit.Case, async: true
  alias GetGeocode.Apis.ViaCep

  test "get_cep/1" do
    %{"localidade" => cidade} = ViaCep.get_cep("69035350")
    assert cidade == "Manaus"
  end

  test "get_cep/1 with input other than string" do
    result = ViaCep.get_cep(1)
    assert result == {:error, "CEP must be a string with 8 digits"}
  end

  test "get_cep/1 with input less than 8 digits" do
    result = ViaCep.get_cep("690353")
    assert result == {:error, "CEP must be 8 digits long"}
  end
end
