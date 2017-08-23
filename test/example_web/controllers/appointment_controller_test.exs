defmodule ExampleWeb.AppointmentControllerTest do
  use ExampleWeb.ConnCase

  alias Example.Activity
  alias Example.Activity.Appointment

  @create_attrs %{type: "some type"}
  @update_attrs %{type: "some updated type"}
  @invalid_attrs %{type: nil}

  def fixture(:appointment) do
    {:ok, appointment} = Activity.create_appointment(@create_attrs)
    appointment
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all appointments", %{conn: conn} do
      conn = get conn, appointment_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create appointment" do
    test "renders appointment when data is valid", %{conn: conn} do
      conn = post conn, appointment_path(conn, :create), appointment: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, appointment_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "type" => "some type"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, appointment_path(conn, :create), appointment: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update appointment" do
    setup [:create_appointment]

    test "renders appointment when data is valid", %{conn: conn, appointment: %Appointment{id: id} = appointment} do
      conn = put conn, appointment_path(conn, :update, appointment), appointment: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, appointment_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "type" => "some updated type"}
    end

    test "renders errors when data is invalid", %{conn: conn, appointment: appointment} do
      conn = put conn, appointment_path(conn, :update, appointment), appointment: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete appointment" do
    setup [:create_appointment]

    test "deletes chosen appointment", %{conn: conn, appointment: appointment} do
      conn = delete conn, appointment_path(conn, :delete, appointment)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, appointment_path(conn, :show, appointment)
      end
    end
  end

  defp create_appointment(_) do
    appointment = fixture(:appointment)
    {:ok, appointment: appointment}
  end
end
