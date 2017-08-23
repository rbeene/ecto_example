defmodule Example.Activity do
  @moduledoc """
  The Activity context.
  """

  import Ecto.Query, warn: false
  alias Example.Repo

  alias Example.Activity.Appointment

  @doc """
  Returns the list of appointments.

  ## Examples

      iex> list_appointments()
      [%Appointment{}, ...]

  """
  def list_appointments do
    Repo.all(Appointment)
  end

  @doc """
  Gets a single appointment.

  Raises `Ecto.NoResultsError` if the Appointment does not exist.

  ## Examples

      iex> get_appointment!(123)
      %Appointment{}

      iex> get_appointment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_appointment!(id), do: Repo.get!(Appointment, id)

  @doc """
  Creates a appointment.

  ## Examples

      iex> create_appointment(%{field: value})
      {:ok, %Appointment{}}

      iex> create_appointment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_appointment(attrs \\ %{}) do
    %Appointment{}
    |> Appointment.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a appointment.

  ## Examples

      iex> update_appointment(appointment, %{field: new_value})
      {:ok, %Appointment{}}

      iex> update_appointment(appointment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_appointment(%Appointment{} = appointment, attrs) do
    appointment
    |> Appointment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Appointment.

  ## Examples

      iex> delete_appointment(appointment)
      {:ok, %Appointment{}}

      iex> delete_appointment(appointment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_appointment(%Appointment{} = appointment) do
    Repo.delete(appointment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking appointment changes.

  ## Examples

      iex> change_appointment(appointment)
      %Ecto.Changeset{source: %Appointment{}}

  """
  def change_appointment(%Appointment{} = appointment) do
    Appointment.changeset(appointment, %{})
  end
end
