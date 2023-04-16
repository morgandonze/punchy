defmodule PunchyApi.Truck do
  import Ecto.Changeset
  alias PunchyApi.{Truck, Repo, PunchCard}

  use Ecto.Schema

  schema "trucks" do
    field(:name, :string)
    field(:card_punches, :integer)
    field(:card_reward, :string)
    field(:food_items, :string)
    belongs_to(:user, PunchyApi.User)
    has_many(:punch_cards, PunnchyApi.PunchCard, on_delete: :delete_all)

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

  def new_punch_card(truck_id, user_id) do
    truck = Repo.get(Truck, truck_id)

    case truck do
      nil ->
        nil

      truck ->
        %PunchCard{
          punch_spots: truck.card_punches,
          punches_earned: 0,
          reward_text: truck.card_reward,
          truck_name: truck.name,
          truck_id: truck.id,
          user_id: user_id
        }
    end

    # Don't commit punch cards to the database until they're punched.
  end
end
