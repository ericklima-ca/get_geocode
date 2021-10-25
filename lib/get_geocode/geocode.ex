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

  def constructor(inputs) do
    values_tuple =
      List.delete_at(Map.keys(%GetGeocode.Geocode{}), 0)
      |> Enum.zip(inputs)

    struct(GetGeocode.Geocode, values_tuple)
  end
end
