defmodule GetGeocode.Builder do
  alias GetGeocode.Apis.{ViaCep, Nominatim}
  alias GetGeocode.Geocode

  def get_geocode(input) do
    cond do
      is_cep?(input) -> get_viacep(input)
      is_addr?(input) -> get_nominatim(input)
      true -> Jason.encode!(%{msg: "Invalid input"})
    end
  end

  defp get_viacep(cep) do
    ViaCep.get_cep(cep)
    |> builder_from_viacep()
  end

  defp get_nominatim(addr) do
    Nominatim.get_data(addr)
    |> builder_from_nominatim()
  end

  defp is_addr?(addr) do
    addr
    |> String.match?(~r/([a-zA-Z]+[\s|,]+[a-zA-Z]+[\s]*)/)
  end

  defp is_cep?(cep) do
    cep
    |> String.match?(~r/\b([0-9]{5}-?[0-9]{3})$/)
  end

  defp builder_from_viacep(result) do
    %{
      "bairro" => neighborhood,
      "cep" => postalcode,
      "localidade" => city,
      "logradouro" => street,
      "uf" => state
    } = result

    %{
      "lon" => lng,
      "lat" => lat,
      "display_name" => full_details
    } =
      Regex.replace(~r/(.)\1+/, ~s[#{street},#{neighborhood},#{city}], "\\1")
      |> Nominatim.get_data()

    Jason.encode!(%Geocode{
      postalcode: postalcode,
      street: street,
      state: state,
      city: city,
      neighborhood: neighborhood,
      lng: lng,
      lat: lat,
      full_details: full_details
    })
  end

  defp builder_from_nominatim(result) do
    %{
      "display_name" => full_details,
      "lat" => lat,
      "lon" => lng
    } = result

    [street, neighborhood, city, _, _, state, _, postalcode | _] =
      full_details
      |> String.split(",")
      |> Enum.map(fn x -> String.trim(x) end)

    Jason.encode!(%Geocode{
      postalcode: postalcode,
      street: street,
      state: state,
      city: city,
      neighborhood: neighborhood,
      lng: lng,
      lat: lat,
      full_details: full_details
    })
  end
end
