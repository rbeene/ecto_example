defmodule ExampleWeb.UserController do
  use ExampleWeb, :controller

  alias Example.Account

  plug Guardian.Plug.EnsureAuthenticated, handler: ExampleWeb.AuthErrorHandler
  plug Guardian.Plug.EnsureResource, handler: ExampleWeb.AuthErrorHandler

  plug ExampleWeb.Plug.CurrentUser

  action_fallback ExampleWeb.FallbackController

  def index(conn, params) do
    users = Account.list_users(conn.assigns.current_user, params)
    render(conn, "index.json", users: users)
  end

  # def create(conn, %{"user" => user_params}) do
  #   with {:ok, %User{} = user} <- Account.create_user(user_params) do
  #     conn
  #     |> put_status(:created)
  #     |> put_resp_header("location", user_path(conn, :show, user))
  #     |> render("show.json", user: user)
  #   end
  # end
  #
  # def show(conn, %{"id" => id}) do
  #   user = Account.get_user!(id)
  #   render(conn, "show.json", user: user)
  # end
  #
  # def update(conn, %{"id" => id, "user" => user_params}) do
  #   user = Account.get_user!(id)
  #
  #   with {:ok, %User{} = user} <- Account.update_user(user, user_params) do
  #     render(conn, "show.json", user: user)
  #   end
  # end
  #
  # def delete(conn, %{"id" => id}) do
  #   user = Account.get_user!(id)
  #   with {:ok, %User{}} <- Account.delete_user(user) do
  #     send_resp(conn, :no_content, "")
  #   end
  # end
end
