defmodule GetGeocode.MixProject do
  use Mix.Project

  def project do
    [
      app: :get_geocode,
      version: "0.0.3",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),

      # Doc
      name: "GetGeocode",
      source_url: "https://github.com/ericklima-ca/get_geocode",
      homepage_url: "https://github.com/ericklima-ca/get_geocode"
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {GetGeocode.Application, []}
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 1.8"},
      {:jason, "~> 1.2"},
      {:ex_doc, "~> 0.25.0", only: :dev, runtime: false},
      {:credo, "~> 1.4", only: [:dev, :test], runtime: false},
      {:ssl_verify_fun, "~> 1.1.6", manager: :rebar3, override: true}
    ]
  end

  defp description() do
    "A simple API to get geodata from CEP (brazilian) or full address format."
  end

  defp package() do
    [
      name: "get_geocode",
      maintainer: ["Erick Amorim"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/ericklima-ca/get_geocode"}
    ]
  end
end
