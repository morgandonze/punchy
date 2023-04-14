defmodule PunchyApi.Repo.Migrations.CreateTrucks do
  use Ecto.Migration

  def change do
    create table(:trucks) do
      add :name, :string
      add :card_punches, :integer
      add :card_reward, :string
      add :user_id, references(:users) # Not deleting trucks when User deleted

      timestamps()
    end

    # create unique_index(:trucks, [:name])
    # create unique_index(:trucks, [:user_id])
  end
end
