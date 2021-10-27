defmodule GetGeocode.Geocode do
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
