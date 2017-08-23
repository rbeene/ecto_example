defmodule Example.Account.Address do
  use Ecto.Schema
  import Ecto.Changeset
  alias Example.Account.{Address,User}


  schema "addresses" do
    field :city, :string
    field :state, :string
    field :street, :string
    field :zip, :string
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(%Address{} = address, attrs) do
    address
    |> cast(attrs, [:street, :city, :zip, :state])
    |> validate_required([:street, :city, :zip, :state])
  end
end
