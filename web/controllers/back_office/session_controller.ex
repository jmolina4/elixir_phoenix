defmodule Dogfamily.SessionController do
  use Dogfamily.Web, :controller

  plug :put_layout, "back_office_login.html"

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"email" => user,
                                    "password" => pass}}) do
    case Dogfamily.Auth.login_by_email_and_pass(conn, user, pass,
                                           repo: Repo) do
      {:ok, conn} ->
        logged_in_user = Guardian.Plug.current_resource(conn)
        conn
        |> put_flash(:info, "Innlogget")
        |> redirect(to: back_office_path(conn, :index))
      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Wrong username/password")
        |> render("new.html")
     end
  end

  def delete(conn, _) do
    conn
    |> Guardian.Plug.sign_out
    |> redirect(to: back_office_path(conn, :index))
  end
end
