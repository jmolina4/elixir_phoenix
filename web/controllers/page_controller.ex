defmodule Dogfamily.PageController do
  use Dogfamily.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
