defmodule Dogfamily.Router do
  use Dogfamily.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Dogfamily do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/back_office", BackOfficeController, :index do
      resources "back_office/users", UserController
      resources "back_office/roles", RoleController
      resources "back_office/residences", ResidenceController do
        resources "/dogs", DogController
      end
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", Dogfamily do
  #   pipe_through :api
  # end
end
