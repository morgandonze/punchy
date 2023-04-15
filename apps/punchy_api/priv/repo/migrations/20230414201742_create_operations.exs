defmodule PunchyApi.Repo.Migrations.CreateOperations do
  use Ecto.Migration

  def change do
    create table(:operations) do
      add :location_id, :string
      add :dayOfWeek, :string
      add :startTime, :utc_datetime
      add :endTime, :utc_datetime
      add :latitude, :float
      add :longitude, :float
      add :menu, :text
      add :truck_id, references(:trucks)

      timestamps()
    end

    create unique_index(:operations, [:location_id])
  end
end
