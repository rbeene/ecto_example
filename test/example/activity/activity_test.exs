defmodule Example.ActivityTest do
  use Example.DataCase

  alias Example.Activity

  describe "appointments" do
    alias Example.Activity.Appointment

    @valid_attrs %{type: "some type"}
    @update_attrs %{type: "some updated type"}
    @invalid_attrs %{type: nil}

    def appointment_fixture(attrs \\ %{}) do
      {:ok, appointment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Activity.create_appointment()

      appointment
    end

    test "list_appointments/0 returns all appointments" do
      appointment = appointment_fixture()
      assert Activity.list_appointments() == [appointment]
    end

    test "get_appointment!/1 returns the appointment with given id" do
      appointment = appointment_fixture()
      assert Activity.get_appointment!(appointment.id) == appointment
    end

    test "create_appointment/1 with valid data creates a appointment" do
      assert {:ok, %Appointment{} = appointment} = Activity.create_appointment(@valid_attrs)
      assert appointment.type == "some type"
    end

    test "create_appointment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Activity.create_appointment(@invalid_attrs)
    end

    test "update_appointment/2 with valid data updates the appointment" do
      appointment = appointment_fixture()
      assert {:ok, appointment} = Activity.update_appointment(appointment, @update_attrs)
      assert %Appointment{} = appointment
      assert appointment.type == "some updated type"
    end

    test "update_appointment/2 with invalid data returns error changeset" do
      appointment = appointment_fixture()
      assert {:error, %Ecto.Changeset{}} = Activity.update_appointment(appointment, @invalid_attrs)
      assert appointment == Activity.get_appointment!(appointment.id)
    end

    test "delete_appointment/1 deletes the appointment" do
      appointment = appointment_fixture()
      assert {:ok, %Appointment{}} = Activity.delete_appointment(appointment)
      assert_raise Ecto.NoResultsError, fn -> Activity.get_appointment!(appointment.id) end
    end

    test "change_appointment/1 returns a appointment changeset" do
      appointment = appointment_fixture()
      assert %Ecto.Changeset{} = Activity.change_appointment(appointment)
    end
  end
end
