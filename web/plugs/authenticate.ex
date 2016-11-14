defmodule Dogfamily.Plug.Authenticate do
  import Dogfamily.Router.Helpers
  import Phoenix.Controller
  import Plug.Conn

  def init(default), do: default

  def call(conn, _default) do
    current_user = get_session(conn, :current_user)
    if current_user do
      assign(conn, :current_user, current_user)
    else
      conn
        |> put_flash(:error, 'You need to be signed in to view this page')
        |> redirect(to: session_path(conn, :new))
    end
  end
end