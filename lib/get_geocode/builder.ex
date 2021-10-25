defmodule GetGeocode.Builder do
  alias GetGeocode.Apis.{ViaCep, Nominatim}
  alias GetGeocode.Geocode

  def get_geocode(input, format \\ :api) do
    cond do
      cep?(input) -> get_viacep(input, format)
      addr?(input) -> get_nominatim(input, format)
      true -> msg_invalid_input(format)
    end
  end

  defp get_viacep(cep, format) do
    ViaCep.get_cep(cep)
    |> builder_from_viacep(format)
  end

  defp get_nominatim(addr, format) do
    Nominatim.get_data(addr)
    |> builder_from_nominatim(format)
  end

  defp addr?(addr) do
    addr
    |> String.match?(~r/([a-zA-Z]+[\s|,]+[a-zA-Z]+[\s]*)/)
  end

  defp cep?(cep) do
    cep
    |> String.match?(~r/\b([0-9]{5}-?[0-9]{3})$/)
  end

  defp builder_from_viacep(result, format) do
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

    wrap_data(
      format,
      [
        postalcode,
        street,
        state,
        city,
        neighborhood,
        lng,
        lat,
        full_details
      ]
    )
  end

  defp builder_from_nominatim(result, format) do
    %{
      "display_name" => full_details,
      "lat" => lat,
      "lon" => lng
    } = result

    [street, neighborhood, city, _, _, state, _, postalcode | _] =
      full_details
      |> String.split(",")
      |> Enum.map(fn x -> String.trim(x) end)

    wrap_data(
      format,
      [
        postalcode,
        street,
        state,
        city,
        neighborhood,
        lng,
        lat,
        full_details
      ]
    )
  end

  defp wrap_data(format, inputs) do
    case format do
      :api -> Jason.encode!(Geocode.constructor(inputs))
      :map -> Geocode.constructor(inputs)
      _ -> "Invalid format!"
    end
  end

  defp msg_invalid_input(format) do
    case format do
      :api -> Jason.encode!(%{msg: "Invalid input"})
      :map -> %{msg: "Invalid input"}
      _ -> "Invalid format!"
    end
  end
end
