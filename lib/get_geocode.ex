defmodule GetGeocode do
  use Application

  alias GetGeocode.Apis.{ViaCep, Nominatim}
  alias GetGeocode.{Geocode, Coords}

  @moduledoc """
  The main module with `get/1` function to retrieve data from CEP (brazilian format), full address format (Nominatim), or a tuple with coordinates `{lat, lng}`.
  """
  @version "0.0.3"
  @moduledoc since: @version

  @doc false
  def start(_type, _args) do
    children = [
      {GetGeocode.Cache, %{}}
    ]

    opts = [strategy: :one_for_one, name: GetGeocode.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @doc """
  Gets geodata from `input`.
  Returns a tuple with `{:ok, %GetGeocode.Geocode{}}`.

  ## Examples
    ```
    # CEP format
    iex> GetGeocode.get "69030000"
    {:ok,
    %GetGeocode.Geocode{
      city: "Manaus",
      coords: %GetGeocode.Coords{lat: "-3.1054153", lng: "-60.0547259"},
      full_details: "Rua Izaurina Braga, Compensa, Manaus, Região Geográfica Imediata de Manaus, Região Geográfica Intermediária de Manaus, Amazonas, Região Norte, 69000-000, Brasil",
      neighborhood: "Compensa",
      postalcode: "69030-000",
      state: "AM",
      street: "Rua Izaurina Braga"
    }}
    
    # with full name
    iex> GetGeocode.get "Rua Compensa, Compensa, Amazonas"
    {:ok,
    %GetGeocode.Geocode{
      city: "Manaus",
      coords: %GetGeocode.Coords{lat: "-3.0967331", lng: "-60.0499325"},
      full_details: "Rua Guanapuris, Compensa, Manaus, Região Geográfica Imediata de Manaus, Região Geográfica Intermediária de Manaus, Amazonas, Região Norte, 69000-000, Brasil",
      neighborhood: "Compensa",
      postalcode: "69000-000",
      state: "Amazonas",
      street: "Rua Guanapuris"
    }}
    ```

    Also works with input being a tuple with coordinates, like `{lat, lng}`.
    ```
    iex> GetGeocode.get {-3.0999329, -60.0552931}
    {:ok,
    %GetGeocode.Geocode{
      city: "Manaus",
      coords: %GetGeocode.Coords{lat: "-3.1004858", lng: "-60.0549478"},
      full_details: "Rua Boa Esperança, Compensa, Manaus, Região Geográfica Imediata de Manaus, Região Geográfica Intermediária de Manaus, Amazonas, Região Norte, 69000-000, Brasil",
      neighborhood: "Compensa",
      postalcode: "69000-000",
      state: "Amazonas",
      street: "Rua Boa Esperança"
    }}
    ```
  """
  @doc since: @version
  def get(input) when is_binary(input) do
    cond do
      cep?(input) -> get_viacep(input)
      addr?(input) -> get_nominatim(input)
      true -> msg_invalid_input()
    end
  end

  def get(coords) when is_tuple(coords) do
    Nominatim.get_data(coords)
    |> builder_from_nominatim()
  end

  defp get_viacep(cep) do
    result = ViaCep.get_cep(cep)

    case result do
      %{"erro" => _} -> msg_invalid_input()
      _ -> builder_from_viacep(result)
    end
  end

  defp get_nominatim(addr) do
    result =
      Regex.replace(~r/(.)\1+/, ~s[#{addr}], "\\1")
      |> Nominatim.get_data()

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
       coords: %Coords{
         lat: lat,
         lng: lng
       },
       postalcode: postalcode,
       street: street,
       neighborhood: neighborhood,
       city: city,
       state: state,
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
       coords: %Coords{
         lat: lat,
         lng: lng
       },
       postalcode: postalcode,
       street: street,
       neighborhood: neighborhood,
       city: city,
       state: state,
       full_details: full_details
     }}
  end

  defp msg_invalid_input() do
    {:error, "Invalid input"}
  end
end
