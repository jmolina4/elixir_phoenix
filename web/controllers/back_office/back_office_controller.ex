defmodule Dogfamily.BackOfficeController do
  use Dogfamily.Web, :controller

  alias Dogfamily.Residence

  plug :put_layout, "back_office.html"

  def index(conn, _params) do
    residences = Repo.all(Residence)
    render conn, "index.html", residences: residences
  end
end
