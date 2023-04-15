defmodule PunchyApi.Operation do
  import Ecto.Changeset
  alias PunchyApi.{Operation, Repo}

  use Ecto.Schema

  schema "operations" do
    field(:location_id, :string)
    field(:day_of_week, :string)
    field(:startTime, :utc_datetime)
    field(:endTime, :utc_datetime)
    field(:latitude, :string)
    field(:longitude, :string)
    belongs_to(:truck, PunchyApi.Truck)

    timestamps()
  end

  def changeset(%Operation{} = operation, attrs) do
    operation
    |> cast(attrs, [
      :location_id,
      :day_of_week,
      :startTime,
      :endTime,
      :latitude,
      :longitude,
      :truck_id
    ])
    |> validate_required([:location_id, :latitude, :longitude, :truck_id])
  end

  def create_operation(attrs \\ %{}) do
    %Operation{}
    |> Operation.changeset(attrs)
    |> Repo.insert()
  end
end
