defmodule PunchyApi.Repo.Migrations.CreatePunchCards do
  use Ecto.Migration

  def change do
    create table(:punch_cards) do
      add :punch_spots, :integer
      add :punches_earned, :integer
      add :reward_text, :string
      add :truck_name, :string
      add :user_id, references(:users)
      add :truck_id, references(:trucks)

      timestamps()
    end

    create unique_index(:punch_cards, [:user_id, :truck_id])
  end
end
