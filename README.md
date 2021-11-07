# GetGeocode

![workflow](https://github.com/ericklima-ca/get_geocode/actions/workflows/elixir.yml/badge.svg)
[![Hex.pm](https://img.shields.io/hexpm/v/get_geocode)](https://hex.pm/packages/get_geocode)

## Installation

The package can be installed by adding `get_geocode` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:get_geocode, "~> 0.0.3"}
  ]
end
```
The docs can be found at [https://hexdocs.pm/get_geocode](https://hexdocs.pm/get_geocode).

## Examples of usage

The main function is `GetGeocode.get/1`, and accepts full address, CEP (brazilian format)
or coordinates in a tuple, lik `{lat, lng}`.

The result is a tuple with `{:ok, %GetGeocode.Geocode{}}`.

### The `GetGeocode.Geocode` struct
``` elixir
%GetGeocode.Geocode{
city: nil,
coords: %GetGeocode.Coords{lat: nil, lng: nil},
full_details: nil,
neighborhood: nil,
postalcode: nil,
state: nil,
street: nil
}
```

----
Getting data from **address**
``` elixir
iex> GetGeocode.get "Avenida Torquato, Manaus"
{:ok,
 %GetGeocode.Geocode{
   city: "Manaus",
   coords: %GetGeocode.Coords{lat: "-3.025279", lng: "-60.021089"},
   full_details: "Avenida Torquato Tapajós, Colonia Terra Nova, Manaus, Região Geográfica Imediata de Manaus, Região Geográfica Intermediária de Manaus, Amazonas, Região Norte, 69000-000, Brasil",
   neighborhood: "Colonia Terra Nova",
   postalcode: "69000-000",
   state: "Amazonas",
   street: "Avenida Torquato Tapajós"
 }}
 ```
 ----
 Getting data from **CEP**
 ``` elixir
 iex> GetGeocode.get "69035350" 
{:ok,
 %GetGeocode.Geocode{
   city: "Manaus",
   coords: %GetGeocode.Coords{lat: "-3.1037338", lng: "-60.0667086"},
   full_details: "Avenida Coronel Cyrilo Neves, Compensa, Manaus, Região Geográfica Imediata de Manaus, Região Geográfica Intermediária de Manaus, Amazonas, Região Norte, 69000-000, Brasil",
   neighborhood: "Compensa",
   postalcode: "69035-350",
   state: "AM",
   street: "Avenida Coronel Cyrillo Neves"
 }}
 ```
----
Getting data from **coordinates**

``` elixir
iex> GetGeocode.get {-3.1037338, -60.0667086}
{:ok,
 %GetGeocode.Geocode{
   city: "Manaus",
   coords: %GetGeocode.Coords{lat: "-3.1043466", lng: "-60.0672105"},
   full_details: "Avenida Coronel Cyrilo Neves, Compensa, Manaus, Região Geográfica Imediata de Manaus, Região Geográfica Intermediária de Manaus, Amazonas, Região Norte, 69000-000, Brasil",
   neighborhood: "Compensa",
   postalcode: "69000-000",
   state: "Amazonas",
   street: "Avenida Coronel Cyrilo Neves"
 }}
 ```