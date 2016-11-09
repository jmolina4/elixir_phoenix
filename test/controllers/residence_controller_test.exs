defmodule Dogfamily.ResidenceControllerTest do
  use Dogfamily.ConnCase

  alias Dogfamily.Residence
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, residence_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing residences"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, residence_path(conn, :new)
    assert html_response(conn, 200) =~ "New residence"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, residence_path(conn, :create), residence: @valid_attrs
    assert redirected_to(conn) == residence_path(conn, :index)
    assert Repo.get_by(Residence, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, residence_path(conn, :create), residence: @invalid_attrs
    assert html_response(conn, 200) =~ "New residence"
  end

  test "shows chosen resource", %{conn: conn} do
    residence = Repo.insert! %Residence{}
    conn = get conn, residence_path(conn, :show, residence)
    assert html_response(conn, 200) =~ "Show residence"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, residence_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    residence = Repo.insert! %Residence{}
    conn = get conn, residence_path(conn, :edit, residence)
    assert html_response(conn, 200) =~ "Edit residence"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    residence = Repo.insert! %Residence{}
    conn = put conn, residence_path(conn, :update, residence), residence: @valid_attrs
    assert redirected_to(conn) == residence_path(conn, :show, residence)
    assert Repo.get_by(Residence, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    residence = Repo.insert! %Residence{}
    conn = put conn, residence_path(conn, :update, residence), residence: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit residence"
  end

  test "deletes chosen resource", %{conn: conn} do
    residence = Repo.insert! %Residence{}
    conn = delete conn, residence_path(conn, :delete, residence)
    assert redirected_to(conn) == residence_path(conn, :index)
    refute Repo.get(Residence, residence.id)
  end
end
