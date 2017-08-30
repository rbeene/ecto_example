defmodule Example.Account.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias Example.Account.{User,Company, Address}
  alias Example.{Activity, Repo}


  schema "users" do
    field :username, :string, null: false
    field :first_name, :string
    field :last_name, :string
    field :gender, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :role, :string, default: "direct_report"
    field :title, :string
    field :status, :string, default: "active"
    belongs_to :manager, User
    belongs_to :company, Company
    has_one :address, Address
    has_many :appointments, Activity.Appointment

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :gender])
    |> validate_required([:first_name, :last_name, :gender])
    |> encrypt_password()
  end

  defp encrypt_password(changeset) do
    if changeset.valid? do
      changeset
      |> put_change(:password_hash, Comeonin.Bcrypt.hashpwsalt(changeset.changes.password))
    else
      changeset
    end
  end
end
