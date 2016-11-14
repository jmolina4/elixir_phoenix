defmodule Dogfamily.ResidenceController do
  use Dogfamily.Web, :controller

  alias Dogfamily.Residence
  alias Dogfamily.Dog

  plug Dogfamily.Plug.Authenticate
  plug :put_layout, "back_office.html"

  def index(conn, _params) do
    residences = Repo.all(Residence)
    render(conn, "index.html", residences: residences)
  end

  def new(conn, _params) do
    changeset = Residence.changeset(%Residence{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"residence" => residence_params}) do
    changeset = Residence.changeset(%Residence{}, residence_params)

    case Repo.insert(changeset) do
      {:ok, _residence} ->
        conn
        |> put_flash(:info, "Residence created successfully.")
        |> redirect(to: residence_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    residence = Repo.get!(Residence, id)
    dogs = Repo.all(Dog, residence_id: id)
    render(conn, "show.html", residence: residence, dogs: dogs)
  end

  def edit(conn, %{"id" => id}) do
    residence = Repo.get!(Residence, id)
    changeset = Residence.changeset(residence)
    render(conn, "edit.html", residence: residence, changeset: changeset)
  end

  def update(conn, %{"id" => id, "residence" => residence_params}) do
    residence = Repo.get!(Residence, id)
    changeset = Residence.changeset(residence, residence_params)

    case Repo.update(changeset) do
      {:ok, residence} ->
        conn
        |> put_flash(:info, "Residence updated successfully.")
        |> redirect(to: residence_path(conn, :show, residence))
      {:error, changeset} ->
        render(conn, "edit.html", residence: residence, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    residence = Repo.get!(Residence, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(residence)

    conn
    |> put_flash(:info, "Residence deleted successfully.")
    |> redirect(to: residence_path(conn, :index))
  end
end
