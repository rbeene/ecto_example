defmodule Example.Account.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias Example.Account.{User,Company, Address}
  alias Example.Activity


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
    |> filter_by_params(params |>  Enum.to_list())
  end

  def list_users(user, "admin_manager", params) do
    params = params |> Map.put("company_id", user.company_id)

    User
    |> filter_by_params(params |> Enum.to_list())
  end

  def list_users(user, "manager", params) do
    params = params
             |> Map.put("company_id", user.company_id)
             |> Map.put("manager_id", user.id)
    User
    |> filter_by_params(params |> Enum.to_list())
  end

  def list_users(user, _role, params) do
    User
    |> where([u], u.id == ^user.id)
    |> filter_by_params(params |> Map.to_list())
  end

  def filter_by_params(query, params) do
    Enum.reduce(params, query, fn
      {"company_id", company_id}, query ->
        filter_by_company(query, company_id)
      {"manager_id", manager_id}, query ->
        filter_by_manager(query, manager_id)
      {"by_gender", gender}, query ->
        filter_by_gender(query, gender)
      {"by_state", state}, query ->
        filter_by_state(query, state)
      {"by_title", title}, query ->
        filter_by_title(query, title)
      {"with_appointment", appointment_type}, query ->
        filter_by_appointment_type(query, appointment_type)
      _, query ->
        query
    end)
  end

  def filter_by_company(query, company_id) do
    query
    |> join(:inner, [u], c in assoc(u, :company))
    |> where([_u, ..., company], company.id == ^company_id)
  end

  def filter_by_manager(query, user_id) do
    query
    |> where([u], u.manager_id == ^user_id or u.id == ^user_id)
  end

  def filter_by_gender(query, gender) do
    query
    |> where([u], u.gender == ^gender)
  end

  def filter_by_state(query, state) do
    query
    |> join(:inner, [u], address in assoc(u, :address))
    |> where([u, ..., address], address.state == ^state)
  end

  def filter_by_title(query, title) do
    query
    |> where([u], u.title == ^title)
  end

  def filter_by_appointment_type(query, type) do
    query
    |> join(:inner, [u], appointments in assoc(u, :appointments))
    |> where([u, ..., appointments], appointments.type == ^type)
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
