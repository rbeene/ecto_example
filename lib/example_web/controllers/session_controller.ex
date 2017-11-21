defmodule ExampleWeb.SessionController do
  use ExampleWeb, :controller
  alias Example.Account
  alias Example.Repo

  def create(conn, %{"username" => username, "password" => password}) do
    username = username |> String.downcase() |> String.trim()
    case Repo.get_by(Account.User, %{username: username}) do
      nil ->
        Comeonin.Bcrypt.dummy_checkpw
        login_failed(conn)
      user ->
        if Comeonin.Bcrypt.checkpw(password, user.password_hash) do
          new_conn = Guardian.Plug.api_sign_in(conn, user, :access)
          token = Guardian.Plug.current_token(new_conn)
          new_conn
            |> put_resp_header("authorization", "Bearer #{token}")
            |> render("token.json", %{token: token, user: user})
        else
          login_failed(conn)
        end
    end
  end

  def create(conn, params) do
    require IEx;IEx.pry
    conn
    |> put_status(400)
    |> render("bad_request.json", %{})
    |> halt
  end

  defp login_failed(conn) do
    conn
    |> put_status(422)
    |> render("login_failed.json", %{})
    |> halt
  end

end
