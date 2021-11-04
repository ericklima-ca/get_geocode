defmodule GetGeocode.Coords do
  @moduledoc """
  Coords struct that holds coordinates data.
  ```
  %GetGeocode.Coords{
      lat: nil,
      lng: nil
  }
  ```
  """
  @moduledoc since: "0.0.3"
  defstruct [:lat, :lng]
end
