defmodule GetGeocode.Apis.Nominatim do
  @moduledoc """
  Nominatim API.
  """
  @url "https://nominatim.openstreetmap.org/search?q=<QUERY>&format=json"

  @doc """
  Gets data from an `addr`ess.

  Results in a list with the data, or a tuple `{:ok, "No result"}`.

  ## Examples
    ```
    iex> GetGeocode.Apis.Nominatim.get_data "Rua Izaurina Braga"
    %{
      "boundingbox" => ["-3.1058605", "-3.105157", "-60.0550895", "-60.0542833"],
      "class" => "highway",
      "display_name" => "Rua Izaurina Braga, Compensa, Manaus, Região Geográfica Imediata de Manaus, Região Geográfica Intermediária de Manaus, Amazonas, Região Norte, 69000-000, Brasil",
      "importance" => 0.4,
      "lat" => "-3.1054153",
      "licence" => "Data © OpenStreetMap contributors, ODbL 1.0. https://osm.org/copyright",
      "lon" => "-60.0547259",
      "osm_id" => 662237608,
      "osm_type" => "way",
      "place_id" => 233020447,
      "type" => "residential"
      }
    ```
  """
  def get_data(addr) do
    result =
      request(addr)
      |> Jason.decode!()

    case result do
      [] -> {:ok, "No result"}
      _ -> hd(result)
    end
  end

  defp request(data) do
    {:ok, %HTTPoison.Response{body: body}} = HTTPoison.get(sanitize_query(data))
    body
  end

  defp sanitize_query(query) when is_binary(query) do
    query
    |> String.trim()
    |> String.downcase()
    |> URI.encode()
    |> gen_query()
  end

  defp sanitize_query({lat, lng} = _query) do
    ~s/#{lat},#{lng}/
    |> gen_query()
  end

  defp gen_query(query) do
    @url
    |> String.replace("<QUERY>", query)
  end
end
