defmodule Dogfamily.UserController do
  use Dogfamily.Web, :controller

  alias Dogfamily.User
  alias Dogfamily.Role

  plug :put_layout, "back_office.html"

  def index(conn, _params) do
    users = Repo.all(from u in User, preload: [:role])
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    roles = Repo.all(Role) |> Enum.map(&{&1.name, &1.id})

    render(conn, "new.html", changeset: changeset, roles: roles)
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)
    roles = Repo.all(Role) |> Enum.map(&{&1.name, &1.id})

    case Dogfamily.Registration.create(changeset, Dogfamily.Repo) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "Your account was created")
        |> redirect(to: user_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:info, "Unable to create account")
        |> render("new.html", changeset: changeset, roles: roles)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    role = Repo.preload(user, :role).role
    render(conn, "show.html", user: user, role: role)
  end

  def edit(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    roles = Repo.all(Role) |> Enum.map(&{&1.name, &1.id})
    changeset = User.changeset(user)
    render(conn, "edit.html", user: user, changeset: changeset, roles: roles)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get!(User, id)
    roles = Repo.all(Role) |> Enum.map(&{&1.name, &1.id})
    changeset = User.changeset(user, user_params)

    case Repo.update(changeset) do
      { :ok, user } ->
        conn
        |> put_flash(:success, "User updated successfully")
        |> redirect(to: user_path(conn, :show, user))
      { :error, changeset} ->
        conn
        |> put_flash(:error, "Error updating user")
        |> render("edit.html", user: user, changeset: changeset, roles: roles)
    end
  end
end
