defmodule Dogfamily.Residence do
  use Dogfamily.Web, :model

  schema "residences" do
    field :name, :string

    has_many :dogs, Dogfamily.Dog
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end
