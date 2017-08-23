defmodule Example.Repo.Migrations.CreateAppointments do
  use Ecto.Migration

  def change do
    create table(:appointments) do
      add :type, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:appointments, [:user_id])
  end
end
