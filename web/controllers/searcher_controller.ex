defmodule Dogfamily.SearcherController do
  use Dogfamily.Web, :controller

  alias Dogfamily.Dog

  def index(conn, _params) do
  	changeset = Dog.changeset(%Dog{})
    render(conn, "index.html", changeset: changeset)
  end

  def show(conn, %{ "brand" => brand }) do
  	dogs = Repo.get_by(Dog, brand: brand)
  	render(conn, "show.html", brand: brand, dogs: dogs)
  end
end
