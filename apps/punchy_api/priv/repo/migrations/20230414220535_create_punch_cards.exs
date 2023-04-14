defmodule PunchyApi.Repo.Migrations.CreatePunchCards do
  use Ecto.Migration

  def change do
    create table(:punch_cards) do
      add :num_punches, :integer
      add :user_id, references(:users)
      add :truck_id, references(:trucks)
    end

    create unique_index(:punch_cards, [:user_id, :truck_id])
  end
end
