defmodule ExampleWeb.Router do
  use ExampleWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
  end

  scope "/api/v1", ExampleWeb do
    pipe_through :api
    post "/login", SessionController, :create, as: :login
    resources "/companies", CompanyController, except: [:new, :edit]
    resources "/users", UserController, except: [:new, :edit]
    resources "/addresses", AddressController, except: [:new, :edit]
    resources "/appointments", AppointmentController, except: [:new, :edit]
  end
end
