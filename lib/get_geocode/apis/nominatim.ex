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
    {:ok, %HTTPoison.Response{body: body}} = HTTPoison.get(gen_query(addr))

    result = Jason.decode!(body)

    case result do
      [] -> {:ok, "No result"}
      _ -> hd(result)
    end
  end

  defp sanitize(query) do
    query
    |> String.trim()
    |> String.replace(" ", "+")
    |> String.downcase()
  end

  defp gen_query(addr) do
    query_sanitized = sanitize(addr)

    @url
    |> String.replace("<QUERY>", query_sanitized)
  end
end
