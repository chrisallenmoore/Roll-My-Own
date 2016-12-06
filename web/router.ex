defmodule Rmo.Router do
  use Rmo.Web, :router

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

  scope "/", Rmo do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/register", RegistrationController, only: [:new, :create]
    get    "/login",  SessionController, :new
    post   "/login",  SessionController, :create
    delete "/logout", SessionController, :delete
    get "/users", UserController, :index
    get "/users/:id", UserController, :show
    get "/users/:id/edit", UserController, :edit
    put "/users/:id", UserController, :update
  end

  # Other scopes may use custom stacks.
  # scope "/api", Rmo do
  #   pipe_through :api
  # end
end
