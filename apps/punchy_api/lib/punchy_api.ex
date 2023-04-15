defmodule PunchyApi do
  import Ecto.Query
  # alias Postgrex.Query
  # alias PunchyApi.Operation
  alias PunchyApi.Repo

  def get_nearby_operations(latitude, longitude, radius \\ 0.25, _datetime \\ nil) do
    # 25_000 is the circumference of Earth in miles
    # 360 degrees on the globe
    approx_miles_per_degree = 25_000 / 360
    mile_in_degrees = 1 / approx_miles_per_degree

    min_lat = latitude - radius * mile_in_degrees
    max_lat = latitude + radius * mile_in_degrees
    min_long = longitude - radius * mile_in_degrees
    max_long = longitude + radius * mile_in_degrees

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

    Repo.all(query)

  end
end
