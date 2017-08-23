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

  def list_users(_user, "admin", params) do
    User
    |> filter_by_params(params)
    |> Repo.all()
  end

  def list_users(user, "admin_manager", params) do
    params = params |> Map.put("company_id", user.company_id)

    User
    |> filter_by_params(params)
    |> Repo.all()
  end

  def list_users(user, "manager", params) do
    params = params
             |> Map.put("company_id", user.company_id)
             |> Map.put("manager_id", user.id)
    User
    |> filter_by_params(params)
    |> Repo.all()
  end

  def list_users(user, _role, params) do
    User
    |> where([u], u.id == ^user.id)
    |> filter_by_params(params)
    |> Repo.all()
  end

  def filter_by_params(query, params) do
    query
    |> by_company(params)
    |> by_manager(params)
    |> by_gender(params)
    |> by_state(params)
    |> by_title(params)
    |> with_appointment(params)
  end

  def by_company(query, %{"company_id" => company_id}) do
    query
    |> join(:inner, [u], c in assoc(u, :company))
    |> where([_u, ..., company], company.id == ^company_id)
  end

  def by_company(query, _params), do: query

  def by_manager(query, %{"manager_id" => user_id}) do
    query
    |> where([u], u.manager_id == ^user_id or u.id == ^user_id)
  end

  def by_manager(query, _params), do: query

  def by_gender(query, %{"gender" => gender}) do
    query
    |> where([u], u.gender == ^gender)
  end

  def by_gender(query, _params), do: query

  def by_state(query, %{"state" => state}) do
    query
    |> join(:inner, [u], address in assoc(u, :address))
    |> where([u, ..., address], address.state == ^state)
  end

  def by_state(query, _params), do: query

  def by_title(query, %{"title" => title}) do
    query
    |> where([u], u.title == ^title)
  end

  def by_title(query, _params), do: query

  def with_appointment(query, %{"appointment_type" => type}) do
    query
    |> join(:inner, [u], appointments in assoc(u, :appointments))
    |> where([u, ..., appointments], appointments.type == ^type)
  end

  def with_appointment(query, _params), do: query

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
