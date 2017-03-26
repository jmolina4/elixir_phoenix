defmodule Dogfamily.Dog do
  use Dogfamily.Web, :model
  use Arc.Ecto.Schema

  schema "dogs" do
    field :name, :string
    field :age, :integer
    field :photo, Dogfamily.ImageUploader.Type

    belongs_to :residence, DogFamily.Residence

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :age])
    |> cast_attachments(params, [:photo])
    |> validate_required([:name, :age, :photo])
  end
end
