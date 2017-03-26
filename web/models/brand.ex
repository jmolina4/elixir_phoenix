defmodule Dogfamily.Brand do
  use Dogfamily.Web, :model

  schema "brands" do
  	field :name, :string
  	field :description, :string  	

  	has_many :dogs, Dogfamily.Dog

  	timestamps()
  end


  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :description])
    |> validate_required([:name, :description])
  end

end