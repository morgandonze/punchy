defmodule PunchyApi.Truck do
  import Ecto.Changeset
  alias PunchyApi.{Truck, Repo}

  use Ecto.Schema

  schema "trucks" do
    field(:name, :string)
    field(:card_punches, :integer)
    field(:card_reward, :string)
    field(:food_items, :string)
    belongs_to(:user, PunchyApi.User)

    timestamps()
  end

  def changeset(%Truck{} = truck, attrs) do
    truck
    |> cast(attrs, [:name, :card_punches, :card_reward, :food_items, :user_id])
    |> validate_required([:name, :card_punches, :card_reward, :user_id])
    |> unique_constraint(:name)
  end

  def create_truck(attrs \\ %{}) do
    %Truck{}
    |> Truck.changeset(attrs)
    |> Repo.insert()
  end
end
