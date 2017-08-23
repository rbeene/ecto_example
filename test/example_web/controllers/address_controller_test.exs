defmodule ExampleWeb.AddressControllerTest do
  use ExampleWeb.ConnCase

  alias Example.Account
  alias Example.Account.Address

  @create_attrs %{city: "some city", state: "some state", street: "some street", zip: "some zip"}
  @update_attrs %{city: "some updated city", state: "some updated state", street: "some updated street", zip: "some updated zip"}
  @invalid_attrs %{city: nil, state: nil, street: nil, zip: nil}

  def fixture(:address) do
    {:ok, address} = Account.create_address(@create_attrs)
    address
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all addresses", %{conn: conn} do
      conn = get conn, address_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create address" do
    test "renders address when data is valid", %{conn: conn} do
      conn = post conn, address_path(conn, :create), address: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, address_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "city" => "some city",
        "state" => "some state",
        "street" => "some street",
        "zip" => "some zip"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, address_path(conn, :create), address: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update address" do
    setup [:create_address]

    test "renders address when data is valid", %{conn: conn, address: %Address{id: id} = address} do
      conn = put conn, address_path(conn, :update, address), address: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, address_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "city" => "some updated city",
        "state" => "some updated state",
        "street" => "some updated street",
        "zip" => "some updated zip"}
    end

    test "renders errors when data is invalid", %{conn: conn, address: address} do
      conn = put conn, address_path(conn, :update, address), address: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete address" do
    setup [:create_address]

    test "deletes chosen address", %{conn: conn, address: address} do
      conn = delete conn, address_path(conn, :delete, address)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, address_path(conn, :show, address)
      end
    end
  end

  defp create_address(_) do
    address = fixture(:address)
    {:ok, address: address}
  end
end
