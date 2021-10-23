defmodule GetGeocode.Apis.ViaCep do
  @moduledoc """
      ## ViaCEP API
      ### https://viacep.com.br/ws/
  """
  @url "https://viacep.com.br/ws"

  def get_cep(cep) do
    cep = sanitize(cep)
    {:ok, %HTTPoison.Response{body: body}} = HTTPoison.get("#{@url}/#{cep}/json")
    Jason.decode!(body)
  end

  defp sanitize(cep) do
    cep
    |> String.trim()
    |> String.replace("-", "")
    |> String.replace(" ", "")
  end
end
