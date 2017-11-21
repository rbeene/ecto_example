defmodule Example.GuardianSerializer do
  @behaviour Guardian.Serializer

  alias Example.Account
  alias Example.Account.User

  def for_token(%User{} = user) do
    {:ok, "User:#{user.id}"}
  end

  def for_token(_) do
    {:error, "Unkown resource type"}
  end

  def from_token("User:" <> id) do
    user = Account.get_user!(id)
    {:ok, user}
  end

  def from_token(_) do
    {:error, "Unkown resource type"}
  end
end

