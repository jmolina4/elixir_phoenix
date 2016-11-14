defmodule Dogfamily.SessionController do
  use Dogfamily.Web, :controller

  plug :put_layout, "back_office_login.html"

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => session_params}) do
  case Dogfamily.Session.login(session_params, Dogfamily.Repo) do
    {:ok, user} ->
      conn
      |> put_session(:current_user, user.id)
      |> put_flash(:info, "Logged in")
      |> redirect(to: back_office_path(conn, :index))
    :error ->
      conn
      |> put_flash(:info, "Wrong email or password")
      |> render("new.html")
  end
end
end
