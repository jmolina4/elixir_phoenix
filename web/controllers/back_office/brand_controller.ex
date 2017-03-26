defmodule Dogfamily.BrandController do
  use Dogfamily.Web, :controller

  plug :put_layout, "back_office.html"

  alias Dogfamily.Brand

  def index(conn, _params) do
    brands = Repo.all(Brand)
    render conn, "index.html", brands: brands
  end

  def new(conn, _params) do
    changeset = Brand.changeset(%Brand{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{ "brand" => brand_params}) do    
    changeset = Brand.changeset(%Brand{}, brand_params)

    case Repo.insert(changeset) do
      { :ok, _brand } ->
        conn
        |> put_flash(:info, "Brand created successfully.")
        |> redirect(to: brand_path(conn, :index))
      { :error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{ "id" => id }) do
    brand = Repo.get!(Brand, id)    
    render(conn, "show.html", brand: brand)
  end

  def edit(conn, %{ "id" => id}) do
    brand = Repo.get(Brand, id)
    changeset = Brand.changeset(brand)
    render(conn, "edit.html", changeset: changeset, brand: brand)
  end

  def update(conn, %{ "id" => id, "brand" => brand_params}) do
    brand = Repo.get(Brand, id)
    changeset = Brand.changeset(brand, brand_params)

    case Repo.update(changeset) do
      { :ok, brand } ->
        conn
        |> put_flash(:info, "Brand updated successfully")
        |> redirect(to: brand_path(conn, :show, brand))
      { :error, changeset } ->
        render(conn, "edit.html", brand: brand, changeset: changeset) 
    end
  end
end
