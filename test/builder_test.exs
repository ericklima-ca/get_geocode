defmodule GetGeocodeBuilderTest do
    use ExUnit.Case, async: true
    import GetGeocode.Builder

    @input_viacep "69035350"
    @input_nominatim "Rua Izaurina Braga, Compensa, Amazonas"

    test "get_geocode/1 from viacep" do
        %{"localidade" => cidade} = get_geocode(@input_viacep)
        assert cidade == "Manaus"
    end

    test "get_geocode/1 from nominatim" do
        result = get_geocode(@input_nominatim)
        assert Map.has_key?(result, "lon")
    end

    test "get_geocode/1 returning error message" do
        %{msg: msg} = get_geocode("?")
        assert msg == "Invalid input"
    end
end