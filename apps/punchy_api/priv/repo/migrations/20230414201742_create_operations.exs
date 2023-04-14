defmodule PunchyApi.Repo.Migrations.CreateOperations do
  use Ecto.Migration

  def change do
    create table(:operations) do
      add :dayOfWeek, :string
      add :startTime, :utc_datetime
      add :endTime, :utc_datetime
      add :latitude, :string
      add :longitude, :string
      add :menu, :text
      add :truck_id, references(:users)

      timestamps()
    end

    create unique_index(:operations, [:truck_id])
  end
end
