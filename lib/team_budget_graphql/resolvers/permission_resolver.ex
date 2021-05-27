defmodule TeamBudgetGraphql.Resolvers.PermissionResolver do
  alias TeamBudget.Permissions

  def create_permission(_parent, %{permission: permission}, _) do
    Permissions.create_permission(permission)
  end

  def list_permissions(_parent, _, _) do
    {:ok, Permissions.list_permissions()}
  end
end
