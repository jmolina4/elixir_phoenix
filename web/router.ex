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

  pipeline :back_office_layout do
    plug :put_layout, { Dogfamily.LayoutView, :back_office }
  end

  scope "/back_office", Dogfamily do
    pipe_through [:browser, :back_office_layout]

    get "/", BackOfficeController, :index
    get "/back_office/login", SessionController, :new
    post "/back_office/login",  SessionController, :create

    resources "/back_office/users", UserController
    resources "/back_office/roles", RoleController
    resources "/back_office/residences", ResidenceController do
      resources "/dogs", DogController
    end
  end

  scope "/", Dogfamily do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", Dogfamily do
  #   pipe_through :api
  # end
end
