defmodule ExampleWeb.UserController do
  use ExampleWeb, :controller

  alias Example.Account

  plug Guardian.Plug.EnsureAuthenticated, handler: ExampleWeb.AuthErrorHandler
  plug Guardian.Plug.EnsureResource, handler: ExampleWeb.AuthErrorHandler

  plug ExampleWeb.Plug.CurrentUser

  action_fallback ExampleWeb.FallbackController

  def index(conn, _params) do
    users = Account.list_users()
    render(conn, "index.json", users: users)
  end

end
