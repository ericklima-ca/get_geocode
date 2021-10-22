defmodule GetGeocodeApisNominatimTest do
    use ExUnit.Case, async: true

    setup do
        %{
            addr:
            "Rua Izaurina Braga, Compensa, Manaus, Região Geográfica Imediata de Manaus, Região Geográfica Intermediária de Manaus, Amazonas, North Region, 69000-000, Brazil"
        }
        end

    test "test get_data/1 result against lat, lon from response", %{addr: addr} do
        %{"lon" => lon, "lat" => lat} = GetGeocode.Apis.Nominatim.get_data(addr)
        assert lon == "-60.0538706"
        assert lat == "-3.1008502"
    end
end