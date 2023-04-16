defmodule PunchyApi do
  import Ecto.Query
  # alias Postgrex.Query
  # alias PunchyApi.Operation
  alias PunchyApi.{Truck, Repo, PunchCard}

  @current_user_id 1

  def get_nearby_operations(latitude, longitude, radius \\ 0.25, _datetime \\ nil) do
    # 25_000 is the circumference of Earth in miles
    # 360 degrees on the globe
    approx_miles_per_degree = 25_000 / 360
    mile_in_degrees = 1 / approx_miles_per_degree

    min_lat = latitude - radius * mile_in_degrees
    max_lat = latitude + radius * mile_in_degrees
    min_long = longitude - radius * mile_in_degrees
    max_long = longitude + radius * mile_in_degrees

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

  def get_nearby_trucks(latitude, longitude) do
    get_nearby_truck_ids(latitude, longitude)
    |> Enum.map(fn truck_id ->
      Repo.get(PunchyApi.Truck, truck_id)
    end)
  end

  def get_nearby_truck_ids(latitude, longitude) do
    PunchyApi.get_nearby_operations(latitude, longitude)
    |> Enum.group_by(& &1.truck_id)
    |> Map.keys()
  end

  def punch_cards_for_nearby_trucks(latitude, longitude) do
    get_nearby_truck_ids(latitude, longitude)
    |> Enum.map(fn truck_id ->
      Truck.new_punch_card(truck_id, @current_user_id)
    end)
  end

  def punch_punch_card(truck_id, user_id) do
    punch_card =
      case Repo.get_by(PunchCard, truck_id: truck_id, user_id: user_id) do
        nil ->
          Truck.new_punch_card(truck_id, user_id)

        punch_card ->
          punch_card
      end

    {state, updated_punch_card} = PunchCard.punch(punch_card)

    case state do
      :complete ->
        state
        # Repo.delete(updated_punch_card)

      :punched ->
        IO.inspect(punch_card)
        IO.inspect(updated_punch_card)
        punch_card
        |> PunchCard.changeset(updated_punch_card)
        # |> Repo.update()
    end
  end

  def users_punch_cards(user_id) do
    :noop
  end
end
