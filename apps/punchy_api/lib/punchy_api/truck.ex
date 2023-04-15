defmodule PunchyApi.Truck do
  import Ecto.Changeset
  alias Hex.API.User
  alias PunchyApi.{Truck, Repo, User}

  use Ecto.Schema

  schema "trucks" do
    field(:name, :string)
    field(:card_punches, :integer)
    field(:card_reward, :string)
    field(:food_items, :string)
    belongs_to(:user, PunchyApi.User)

    timestamps()
  end

  def changeset(%Truck{} = user, attrs) do
    user
    |> cast(attrs, [:name, :card_punches, :card_reward, :food_items, :user_id])
    |> validate_required([:name, :card_punches, :card_reward, :user_id])
    |> unique_constraint(:name)
  end

end
