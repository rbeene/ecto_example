defmodule Example.Activity.Appointment do
  use Ecto.Schema
  import Ecto.Changeset
  alias Example.Activity.Appointment


  schema "appointments" do
    field :type, :string
    belongs_to :user, Example.Account.User

    timestamps()
  end

  @doc false
  def changeset(%Appointment{} = appointment, attrs) do
    appointment
    |> cast(attrs, [:type])
    |> validate_required([:type])
  end
end
