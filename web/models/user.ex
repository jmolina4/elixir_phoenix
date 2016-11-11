defmodule Dogfamily.User do
  use Dogfamily.Web, :model

  schema "users" do
    field :email, :string
    field :crypted_password, :string

    belongs_to :role, Dogfamily.Role

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :crypted_password, :role_id])
    |> validate_required([:email, :crypted_password, :role_id])
    |> unique_constraint(:email)
  end
end
