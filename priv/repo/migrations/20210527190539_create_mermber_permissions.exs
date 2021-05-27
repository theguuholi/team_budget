defmodule TeamBudget.Repo.Migrations.CreateMermberPermissions do
  use Ecto.Migration

  def change do
    create table(:mermber_permissions, primary_key: false) do
      add :id, :binary_id, primary_key: true

      add :member_id,
          references(:members, on_delete: :delete_all, on_update: :update_all, type: :binary_id)

      add :permission_id,
          references(:permissions,
            on_delete: :delete_all,
            on_update: :update_all,
            type: :binary_id
          )

      timestamps()
    end

    create index(:mermber_permissions, [:member_id])
    create index(:mermber_permissions, [:permission_id])
  end
end
