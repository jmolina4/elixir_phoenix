defmodule Dogfamily.DogTest do
  use Dogfamily.ModelCase

  alias Dogfamily.Dog

  @valid_attrs %{age: 42, name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Dog.changeset(%Dog{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Dog.changeset(%Dog{}, @invalid_attrs)
    refute changeset.valid?
  end
end
