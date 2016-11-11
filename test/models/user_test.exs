defmodule Dogfamily.UserTest do
  use Dogfamily.ModelCase

  alias Dogfamily.User

  @valid_attrs %{crypted_password: "some content", email: "some content", role_id: 1}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
