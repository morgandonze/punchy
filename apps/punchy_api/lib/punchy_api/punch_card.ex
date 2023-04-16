defmodule PunchyApi.PunchCard do
  import Ecto.Changeset
  alias PunchyApi.{PunchCard, Repo}

  use Ecto.Schema

  schema "punch_cards" do
    field(:punch_spots, :integer)
    field(:punches_earned, :integer)
    field(:reward_text, :string)
    field(:truck_name, :string)
    belongs_to(:truck, PunchyApi.Truck)
    belongs_to(:user, PunchyApi.User)

    timestamps()
  end

  def changeset(%PunchCard{} = punch_card, attrs) do
    punch_card
    |> cast(attrs, [:punch_spots, :punches_earned, :reward_text, :truck_name, :truck_id, :user_id])
    |> validate_required([:punch_spots, :reward_text, :truck_name, :truck_id, :user_id])
  end

  def punch(punch_card) do
    if punch_card.punches_earned + 1 == punch_card.punch_spots do
      {:complete, punch_card}
    else
      {
        :punched,
        %{
          punches_earned: punch_card.punches_earned + 1
        }
      }
    end
  end
end
