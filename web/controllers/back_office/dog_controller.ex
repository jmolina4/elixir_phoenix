defmodule Dogfamily.DogController do
  use Dogfamily.Web, :controller

  alias Dogfamily.Dog

  plug :assign_residence
  plug :put_layout, "back_office.html"

  def index(conn, _params) do
    dogs = Repo.all(Dog)
    render(conn, "index.html", dogs: dogs)
  end

  def new(conn, _params) do
    changeset = Dog.changeset(%Dog{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"dog" => dog_params}) do
    changeset = Dog.changeset(%Dog{}, dog_params)

    case Repo.insert(changeset) do
      {:ok, _dog} ->
        conn
        |> put_flash(:info, "Dog created successfully.")
        |> redirect(to: residence_dog_path(conn, :index, conn.assigns[:residence]))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    dog = Repo.get!(Dog, id)
    render(conn, "show.html", dog: dog)
  end

  def edit(conn, %{"id" => id}) do
    dog = Repo.get!(Dog, id)
    changeset = Dog.changeset(dog)
    render(conn, "edit.html", dog: dog, changeset: changeset)
  end

  def update(conn, %{"id" => id, "dog" => dog_params}) do
    dog = Repo.get!(Dog, id)
    changeset = Dog.changeset(dog, dog_params)

    case Repo.update(changeset) do
      {:ok, dog} ->
        conn
        |> put_flash(:info, "Dog updated successfully.")
        |> redirect(to: residence_dog_path(conn, :show, conn.assigns[:residence], dog))
      {:error, changeset} ->
        render(conn, "edit.html", dog: dog, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    dog = Repo.get!(Dog, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(dog)

    conn
    |> put_flash(:info, "Dog deleted successfully.")
    |> redirect(to: residence_dog_path(conn, :index, conn.assigns[:residence]))
  end

  defp assign_residence(conn, _opts) do
    case conn.params do
      %{"residence_id" => residence_id} ->
        residence = Repo.get(Dogfamily.Residence, residence_id)
        assign(conn, :residence, residence)
      _ ->
        conn
    end
  end
end
