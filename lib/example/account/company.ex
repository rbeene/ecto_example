defmodule Example.Account.Company do
  use Ecto.Schema
  import Ecto.Changeset
  alias Example.Account.Company


  schema "companies" do
    field :name, :string
    field :status, :string

    timestamps()
  end

  @doc false
  def changeset(%Company{} = company, attrs) do
    company
    |> cast(attrs, [:name, :status])
    |> validate_required([:name, :status])
  end
end
