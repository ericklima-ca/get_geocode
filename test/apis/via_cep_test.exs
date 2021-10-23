defmodule GetGeocodeApisViaCepTest do
    use ExUnit.Case, async: true
    alias GetGeocode.Apis.ViaCep

    test "get_cep/1" do
        %{"localidade" => cidade} = ViaCep.get_cep("69035350")
        assert cidade == "Manaus"
    end
end