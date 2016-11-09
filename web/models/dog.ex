defmodule Dogfamily.Dog do
  use Dogfamily.Web, :model

  schema "dogs" do
    field :name, :string
    field :age, :integer

    belongs_to :residence, DogFamily.Residence

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :age])
    |> validate_required([:name, :age])
  end
end
