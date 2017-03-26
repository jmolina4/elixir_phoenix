defmodule Dogfamily.DogRequestController do
  use Dogfamily.Web, :controller

  alias Dogfamily.Dog 

  def index(conn, _params) do          
    dogs = Repo.all(Dog)
    render(conn, "index.html", dogs: dogs)
  end 

  def new(conn, params) do
    IO.puts(params["search"]["brand"])
    conn
    |> redirect(to: dog_request_path(conn, :index))
  end

  def show(conn, %{ "dog_params" => dog_params }) do
  	dogs = Repo.get_by(Dog, brand: dog_params[:brand])
    conn
    |> redirect(to: dog_request_path(conn, :index))
  end
end
