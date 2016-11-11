defmodule Dogfamily.DogControllerTest do
  use Dogfamily.ConnCase

  alias Dogfamily.Dog
  alias Dogfamily.Residence
  @valid_attrs %{age: 42, name: "some content"}
  @invalid_attrs %{}

  setup do
    {:ok, residence} = create_residence
    {:ok, residence: residence}
  end

  test "lists all entries on index", %{conn: conn, residence: residence} do
    conn = get conn, residence_dog_path(conn, :index, residence)
    assert html_response(conn, 200) =~ "Listing dogs"
  end

  test "renders form for new resources", %{conn: conn, residence: residence} do
    conn = get conn, residence_dog_path(conn, :new, residence)
    assert html_response(conn, 200) =~ "New dog"
  end

  test "creates resource and redirects when data is valid", %{conn: conn, residence: residence} do
    conn = post conn, residence_dog_path(conn, :create, residence), dog: @valid_attrs
    assert redirected_to(conn) == residence_dog_path(conn, :index, residence)
    assert Repo.get_by(Dog, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn, residence: residence} do
    conn = post conn, residence_dog_path(conn, :create, residence), dog: @invalid_attrs
    assert html_response(conn, 200) =~ "New dog"
  end

  test "shows chosen resource", %{conn: conn, residence: residence} do
    dog = Repo.insert! %Dog{}
    conn = get conn, residence_dog_path(conn, :show, residence, dog)
    assert html_response(conn, 200) =~ "Show dog"
  end

  test "renders page not found when id is nonexistent", %{conn: conn, residence: residence} do
    assert_error_sent 404, fn ->
      get conn, residence_dog_path(conn, :show, residence, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn, residence: residence} do
    dog = Repo.insert! %Dog{}
    conn = get conn, residence_dog_path(conn, :edit, residence, dog)
    assert html_response(conn, 200) =~ "Edit dog"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn, residence: residence} do
    dog = Repo.insert! %Dog{}
    conn = put conn, residence_dog_path(conn, :update, residence, dog), dog: @valid_attrs
    assert redirected_to(conn) == residence_dog_path(conn, :show, residence, dog)
    assert Repo.get_by(Dog, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn, residence: residence} do
    dog = Repo.insert! %Dog{}
    conn = put conn, residence_dog_path(conn, :update, residence, dog), dog: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit dog"
  end

  test "deletes chosen resource", %{conn: conn, residence: residence} do
    dog = Repo.insert! %Dog{}
    conn = delete conn, residence_dog_path(conn, :delete, residence, dog)
    assert redirected_to(conn) == residence_dog_path(conn, :index, residence)
    refute Repo.get(Dog, dog.id)
  end

  defp create_residence do
    Residence.changeset(%Residence{}, %{name: "test", dogs: []})
    |> Repo.insert
  end
end
