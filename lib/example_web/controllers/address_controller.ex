defmodule ExampleWeb.AddressController do
  use ExampleWeb, :controller

  alias Example.Account
  alias Example.Account.Address

  action_fallback ExampleWeb.FallbackController

  def index(conn, _params) do
    addresses = Account.list_addresses()
    render(conn, "index.json", addresses: addresses)
  end

  def create(conn, %{"address" => address_params}) do
    with {:ok, %Address{} = address} <- Account.create_address(address_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", address_path(conn, :show, address))
      |> render("show.json", address: address)
    end
  end

  def show(conn, %{"id" => id}) do
    address = Account.get_address!(id)
    render(conn, "show.json", address: address)
  end

  def update(conn, %{"id" => id, "address" => address_params}) do
    address = Account.get_address!(id)

    with {:ok, %Address{} = address} <- Account.update_address(address, address_params) do
      render(conn, "show.json", address: address)
    end
  end

  def delete(conn, %{"id" => id}) do
    address = Account.get_address!(id)
    with {:ok, %Address{}} <- Account.delete_address(address) do
      send_resp(conn, :no_content, "")
    end
  end
end
