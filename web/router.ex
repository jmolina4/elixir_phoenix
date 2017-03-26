defmodule Dogfamily.Router do
  use Dogfamily.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :browser_auth do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.EnsureAuthenticated, handler: Dogfamily.Token
    plug Guardian.Plug.LoadResource
  end

  pipeline :back_office_layout do
    plug :put_layout, { Dogfamily.LayoutView, :back_office }
  end

  scope "/back_office", Dogfamily do
    pipe_through [:browser, :back_office_layout, :browser_auth]

    get "/", BackOfficeController, :index

    resources "/users", UserController
    resources "/roles", RoleController
    resources "/brands", BrandController
    resources "/residences", ResidenceController do
      resources "/dogs", DogController
    end
  end

  scope "/", Dogfamily do
    pipe_through :browser # Use the default browser stack

    resources "/sessions", SessionController, only: [:new, :create, :delete]

    resources "/", DogRequestController
    post "/new", DogRequestController, :new
  end

  # Other scopes may use custom stacks.
  # scope "/api", Dogfamily do
  #   pipe_through :api
  # end
end
