defmodule GetGeocode.Apis.ViaCep do
  @moduledoc """
      ## ViaCEP API
      From https://viacep.com.br/
  """
  @url "https://viacep.com.br/ws"

  def get_cep(cep) when is_binary(cep) do
    cep_sanitized = sanitize(cep)

    cond do
      String.length(cep_sanitized) == 8 -> send_request(cep_sanitized)
      true -> {:error, "CEP must be 8 digits long"}
    end
  end

  def get_cep(_) do
    {:error, "CEP must be a string with 8 digits"}
  end

  defp sanitize(cep) do
    cep
    |> String.trim()
    |> String.replace("-", "")
    |> String.replace(" ", "")
  end

  defp send_request(cep) do
    {:ok, %HTTPoison.Response{body: body}} = HTTPoison.get("#{@url}/#{cep}/json")
    Jason.decode!(body)
  end
end
