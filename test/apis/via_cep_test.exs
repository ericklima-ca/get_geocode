defmodule GetGeocodeApisViaCepTest do
    use ExUnit.Case, async: true

    test "get_cep/1" do
        %{"localidade" => cidade} = GetGeocode.Apis.ViaCep.get_cep("69035350")
        assert cidade == "Manaus"
    end

    test "get_cep/1" do
        %{"localidade" => cidade} = GetGeocode.Apis.ViaCep.get_cep("69035350")
        assert cidade == "Manaus"
    end
end