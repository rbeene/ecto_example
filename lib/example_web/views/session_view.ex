defmodule ExampleWeb.SessionView do
  use ExampleWeb, :view

  def render("token.json", %{token: token, user: user}) do
    %{data: %{token: token, status: user.status, first_name: user.first_name, last_name: user.last_name, id: user.id}}
  end

  def render("logout.json", _) do
    %{}
  end

  def render("login_failed.json", _) do
    %{errors: ["Invalid email/password combination!"]}
  end

  def render("bad_request.json", _) do
    %{errors: ["bad request!"]}
  end
end
