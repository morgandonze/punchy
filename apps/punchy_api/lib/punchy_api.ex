defmodule PunchyApi do
  @moduledoc """
  Documentation for `PunchyApi`.
  """
  alias PunchyApi.Location

  @doc """

  Gets operations near the time and place specified by the params.

  ## Params

  - latitude
  - longitude
  - datetime

  """
  def get_nearby_operations(latitude, longitude, datetime) do
    nearby_radius_in_miles = 2
    approx_miles_per_degree = 25_000 / 360
    mile_in_degrees = 1 / approx_miles_per_degree

    min_lat = latitude - nearby_radius_in_miles * mile_in_degrees
    max_lat = latitude + nearby_radius_in_miles * mile_in_degrees
    min_long = longitude - nearby_radius_in_miles * mile_in_degrees
    max_long = longitude + nearby_radius_in_miles * mile_in_degrees

    # Use min/max lat/long in query to select nearby Operations

  end
end
