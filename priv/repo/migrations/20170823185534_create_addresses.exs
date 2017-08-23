defmodule Example.Repo.Migrations.CreateAddresses do
  use Ecto.Migration

  def change do
    create table(:addresses) do
      add :street, :string
      add :city, :string
      add :zip, :string
      add :state, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:addresses, [:user_id])
  end
end
