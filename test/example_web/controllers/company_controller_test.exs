defmodule ExampleWeb.CompanyControllerTest do
  use ExampleWeb.ConnCase

  alias Example.Account
  alias Example.Account.Company

  @create_attrs %{name: "some name", status: "some status"}
  @update_attrs %{name: "some updated name", status: "some updated status"}
  @invalid_attrs %{name: nil, status: nil}

  def fixture(:company) do
    {:ok, company} = Account.create_company(@create_attrs)
    company
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all companies", %{conn: conn} do
      conn = get conn, company_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create company" do
    test "renders company when data is valid", %{conn: conn} do
      conn = post conn, company_path(conn, :create), company: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, company_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "name" => "some name",
        "status" => "some status"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, company_path(conn, :create), company: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update company" do
    setup [:create_company]

    test "renders company when data is valid", %{conn: conn, company: %Company{id: id} = company} do
      conn = put conn, company_path(conn, :update, company), company: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, company_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "name" => "some updated name",
        "status" => "some updated status"}
    end

    test "renders errors when data is invalid", %{conn: conn, company: company} do
      conn = put conn, company_path(conn, :update, company), company: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete company" do
    setup [:create_company]

    test "deletes chosen company", %{conn: conn, company: company} do
      conn = delete conn, company_path(conn, :delete, company)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, company_path(conn, :show, company)
      end
    end
  end

  defp create_company(_) do
    company = fixture(:company)
    {:ok, company: company}
  end
end
