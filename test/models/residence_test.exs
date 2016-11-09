defmodule Dogfamily.ResidenceTest do
  use Dogfamily.ModelCase

  alias Dogfamily.Residence

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Residence.changeset(%Residence{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Residence.changeset(%Residence{}, @invalid_attrs)
    refute changeset.valid?
  end
end
