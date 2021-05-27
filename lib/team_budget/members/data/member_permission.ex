defmodule TeamBudget.Members.Data.MemberPermission do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "mermber_permissions" do
    field :member_id, :binary_id
    field :permission_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(member_permission, attrs) do
    member_permission
    |> cast(attrs, [])
    |> validate_required([])
  end
end
