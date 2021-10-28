defmodule GetGeocode.Geocode do
  @moduledoc """
  Geocode struct.
  ```
  %GetGeocode.Geocode{
    city: nil,
    full_details: nil,
    lat: nil,
    lng: nil,
    neighborhood: nil,
    postalcode: nil,
    state: nil,
    street: nil
  }
  ```
  """
  defstruct [
    :postalcode,
    :street,
    :neighborhood,
    :city,
    :state,
    :lat,
    :lng,
    :full_details
  ]
end
