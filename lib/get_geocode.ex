defmodule GetGeocode do
  alias GetGeocode.Apis.{ViaCep, Nominatim}
  alias GetGeocode.Geocode

  def get(input) when is_binary(input) do
    cond do
      cep?(input) -> get_viacep(input)
      addr?(input) -> get_nominatim(input)
      true -> msg_invalid_input()
    end
  end

  def get(_) do
    msg_invalid_input()
  end

  def get() do
    msg_invalid_input()
  end

  defp get_viacep(cep) do
    result = ViaCep.get_cep(cep)

    case result do
      %{"erro" => _} -> msg_invalid_input()
      _ -> builder_from_viacep(result)
    end
  end

  defp get_nominatim(addr) do
    result = Nominatim.get_data(addr)

    case result do
      {_, _} -> result
      _ -> builder_from_nominatim(result)
    end
  end

  defp addr?(addr) do
    addr
    |> String.match?(~r/([a-zA-Z]+[\s|,]+[a-zA-Z]+[\s]*)/)
  end

  defp cep?(cep) do
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

    {:ok,
     %Geocode{
       postalcode: postalcode,
       street: street,
       neighborhood: neighborhood,
       city: city,
       state: state,
       lat: lat,
       lng: lng,
       full_details: full_details
     }}
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

    {:ok,
     %Geocode{
       postalcode: postalcode,
       street: street,
       neighborhood: neighborhood,
       city: city,
       state: state,
       lat: lat,
       lng: lng,
       full_details: full_details
     }}
  end

  defp msg_invalid_input() do
    {:error, "Invalid input"}
  end
end
