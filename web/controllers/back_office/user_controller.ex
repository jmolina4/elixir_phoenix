defmodule Dogfamily.UserController do
  use Dogfamily.Web, :controller

  alias Dogfamily.User
  alias Dogfamily.Role

  plug Dogfamily.Plug.Authenticate
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
end