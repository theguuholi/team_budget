defmodule TeamBudget.Repo.Migrations.CreateMemberRoles do
  use Ecto.Migration

  def change do
    create table(:member_roles, primary_key: false) do
      add :id, :binary_id, primary_key: true

      add :member_id,
          references(:members, on_delete: :delete_all, on_update: :update_all, type: :binary_id)

      add :role_id,
          references(:roles, on_delete: :delete_all, on_update: :update_all, type: :binary_id)

      timestamps()
    end

    create index(:member_roles, [:member_id])
    create index(:member_roles, [:role_id])
  end
end
