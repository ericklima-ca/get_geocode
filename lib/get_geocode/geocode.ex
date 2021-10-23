defmodule GetGeocode.Geocode do
  @derive [Jason.Encoder]
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
