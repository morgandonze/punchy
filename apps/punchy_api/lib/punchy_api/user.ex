defmodule PunchyApi.User do
  # defstruct [:username, :id, :inserted_at, :updated_at]
  import Ecto.Changeset
  alias PunchyApi.{User}

  use Ecto.Schema

  schema "users" do
    field :username, :string

    timestamps()
  end

  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:username])
    |> validate_required([:username])
    |> validate_length(:username, min: 3)
    |> unique_constraint(:username)
  end
end
