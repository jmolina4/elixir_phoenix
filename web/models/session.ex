defmodule Dogfamily.Session do
  alias Dogfamily.User
  require Logger

  def login(params, repo) do
    user = repo.get_by(User, email: String.downcase(params["email"]))
    case authenticate(user, params["password"]) do
      true -> {:ok, user}
      _    -> :error
    end
  end

  defp authenticate(user, password) do
    Logger.debug "Var value: #{inspect(user)}"
    Logger.debug "Var value: #{inspect(password)}"
    Logger.debug "Var value: #{inspect(user.password)}"
    case user do
      nil -> false
      _   -> Comeonin.Bcrypt.checkpw(password, user.crypted_password)
    end
  end

  def current_user(conn) do
    id = Plug.Conn.get_session(conn, :current_user)
    if id, do: Dogfamily.Repo.get(User, id)
  end

  def logged_in?(conn), do: !!current_user(conn)
end