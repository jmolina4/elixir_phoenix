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
    roles = Repo.all(Role) |> Enum.map(&{&1.id, &1.name})

    render(conn, "new.html", changeset: changeset, roles: roles)
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)
    roles = Repo.all(Role) |> Enum.map(&{&1.name, &1.id})

    case Repo.insert(changeset) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: user_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset, roles: roles)
    end
  end
end