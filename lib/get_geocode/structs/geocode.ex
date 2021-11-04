defmodule GetGeocode.Geocode do
  alias GetGeocode.Coords

  @moduledoc """
  Geocode struct.
  ```
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
  """
  @moduledoc since: "0.0.3"
  defstruct [
    :postalcode,
    :street,
    :neighborhood,
    :city,
    :state,
    :full_details,
    coords: %Coords{}
  ]
end
