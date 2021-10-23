defmodule GetGeocode.Apis.Nominatim do
  @url "https://nominatim.openstreetmap.org/search?q=<QUERY>&format=json"

  def get_data(addr) do
    {:ok, %HTTPoison.Response{body: body}} = HTTPoison.get(gen_query(addr))

    Jason.decode!(body)
    |> hd()
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
