defmodule Example.Repo.Migrations.CreateCompanies do
  use Ecto.Migration

  def change do
    create table(:companies) do
      add :name, :string
      add :status, :string

      timestamps()
    end

  end
end
