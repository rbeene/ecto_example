defmodule ExampleWeb.AuthErrorHandler do
  use ExampleWeb, :controller

  def unauthenticated(conn, _params) do
    conn
    |> put_status(:unauthorized)
    |> json(%{"errors" => ["Unauthorized Request"]})
    |> halt
  end

  def no_resource(conn, _) do
    conn
    |> put_status(:unauthorized)
    |> json(%{"errors" => ["Unauthorized Request"]})
    |> halt
  end
end
