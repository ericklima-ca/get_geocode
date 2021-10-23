defmodule GetGeocode.Builder do
    alias GetGeocode.Apis.{ViaCep, Nominatim}
    
    def get_geocode(input) do
        cond do
            is_cep(input) -> get_viacep(input)
            is_addr(input) -> get_nominatim(input)
            true -> %{msg: "Invalid input"}
        end
    end

    defp get_viacep(cep) do
        ViaCep.get_cep(cep)
    end
    defp get_nominatim(addr) do
        Nominatim.get_data(addr)
    end
    defp is_addr(addr) do
        addr
        |> String.match?(~r/([a-zA-Z]+[\s|,]+[a-zA-Z]+[\s]*)/)
    end
    defp is_cep(cep) do
        cep
        |> String.match?(~r/\b([0-9]{5}-?[0-9]{3})$/)
    end
end