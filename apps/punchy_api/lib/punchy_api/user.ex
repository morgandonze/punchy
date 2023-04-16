defmodule PunchyApi.User do
  import Ecto.Changeset
  alias PunchyApi.{User, Truck, PunchCard, Repo}

  use Ecto.Schema

  schema "users" do
    field(:username, :string)
    has_many(:trucks, PunchyApi.Truck, on_delete: :delete_all)
    has_many(:punch_cards, PunchyApi.PunchCard, on_delete: :delete_all)

    timestamps()
  end

  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:username])
    |> validate_required([:username])
    |> validate_length(:username, min: 3)
    |> unique_constraint(:username)
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end
end
