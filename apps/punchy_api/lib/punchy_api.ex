defmodule PunchyApi do
  import Ecto.Query
  alias Postgrex.Query
  alias PunchyApi.{Operation, Repo}

  def get_nearby_operations(latitude, longitude, radius \\ 0.25, _datetime \\ nil) do
    nearby_radius_in_miles = radius
    approx_miles_per_degree = 25_000 / 360
    mile_in_degrees = 1 / approx_miles_per_degree

    min_lat = latitude - nearby_radius_in_miles * mile_in_degrees
    max_lat = latitude + nearby_radius_in_miles * mile_in_degrees
    min_long = longitude - nearby_radius_in_miles * mile_in_degrees
    max_long = longitude + nearby_radius_in_miles * mile_in_degrees

    # Use min/max lat/long in query to select nearby Operations
    query =
      from(
        o in "operations",
        select: [:latitude, :longitude, :truck_id],
        where:
          o.latitude >= type(^min_lat, :float) and
            o.latitude <= type(^max_lat, :float) and
            o.longitude >= type(^min_long, :float) and
            o.longitude <= type(^max_long, :float)
      )

    IO.inspect(query)

    Repo.all(query)
    |> Enum.count()

    # |> Enum.
  end
end
