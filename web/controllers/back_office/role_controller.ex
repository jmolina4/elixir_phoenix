defmodule Dogfamily.RoleController do
  use Dogfamily.Web, :controller

  plug Dogfamily.Plug.Authenticate
  alias Dogfamily.Role

  plug :put_layout, "back_office.html"

  def index(conn, _params) do
    roles = Repo.all(Role)
    render(conn, "index.html", roles: roles)
  end

  def new(conn, _params) do
    changeset = Role.changeset(%Role{})

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"role" => role_params}) do
    changeset = Role.changeset(%Role{}, role_params)

    case Repo.insert(changeset) do
      {:ok, _role} ->
        conn
        |> put_flash(:info, "role created successfully.")
        |> redirect(to: role_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end