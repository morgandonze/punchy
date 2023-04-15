defmodule PunchyApi.Repo.Migrations.CreateOperations do
  use Ecto.Migration

  def change do
    create table(:operations) do
      add :location_id, :string
      add :dayOfWeek, :string
      add :startTime, :utc_datetime
      add :endTime, :utc_datetime
      add :latitude, :string
      add :longitude, :string
      add :menu, :text
      add :truck_id, references(:trucks)

      timestamps()
    end

    create unique_index(:operations, [:location_id])
  end
end
