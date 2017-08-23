defmodule Example.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string, null: false
      add :first_name, :string
      add :last_name, :string
      add :gender, :string
      add :company_id, references(:companies, on_delete: :nothing)
      add :manager_id, references(:users, on_delete: :nothing)
      add :password_hash, :string
      add :status, :string, default: "active"
      add :role, :string, default: "direct_report"
      add :title, :string

      timestamps()
    end

    create index(:users, [:company_id])
    create index(:users, [:manager_id])
  end
end
