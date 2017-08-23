defmodule ExampleWeb.AppointmentController do
  use ExampleWeb, :controller

  alias Example.Activity
  alias Example.Activity.Appointment

  action_fallback ExampleWeb.FallbackController

  def index(conn, _params) do
    appointments = Activity.list_appointments()
    render(conn, "index.json", appointments: appointments)
  end

  def create(conn, %{"appointment" => appointment_params}) do
    with {:ok, %Appointment{} = appointment} <- Activity.create_appointment(appointment_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", appointment_path(conn, :show, appointment))
      |> render("show.json", appointment: appointment)
    end
  end

  def show(conn, %{"id" => id}) do
    appointment = Activity.get_appointment!(id)
    render(conn, "show.json", appointment: appointment)
  end

  def update(conn, %{"id" => id, "appointment" => appointment_params}) do
    appointment = Activity.get_appointment!(id)

    with {:ok, %Appointment{} = appointment} <- Activity.update_appointment(appointment, appointment_params) do
      render(conn, "show.json", appointment: appointment)
    end
  end

  def delete(conn, %{"id" => id}) do
    appointment = Activity.get_appointment!(id)
    with {:ok, %Appointment{}} <- Activity.delete_appointment(appointment) do
      send_resp(conn, :no_content, "")
    end
  end
end
