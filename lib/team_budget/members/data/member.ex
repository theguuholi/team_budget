defmodule TeamBudget.Members.Data.Member do
  use Ecto.Schema
  import Ecto.Changeset
  alias TeamBudget.Accounts.Data.User
  alias TeamBudget.Teams.Data.Team
  alias TeamBudget.Roles.Data.Role
  alias TeamBudget.Members.Data.MemberRole
  alias TeamBudget.Members.Data.MemberPermission
  alias TeamBudget.Permissions.Data.Permission

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "members" do
    belongs_to :user, User
    belongs_to :team, Team

    many_to_many :roles, Role, join_through: MemberRole, on_replace: :delete
    many_to_many :permissions, Permission, join_through: MemberPermission, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(attrs) do
    changeset(%__MODULE__{}, attrs)
  end

  def changeset(member, attrs) do
    member
    |> cast(attrs, [:user_id, :team_id])
    |> validate_required([:user_id, :team_id])
  end

  def insert_roles(member, roles) do
    member
    |> cast(%{}, [])
    |> put_assoc(:roles, roles)
  end

  def insert_permissions(member, permissions) do
    member
    |> cast(%{}, [])
    |> put_assoc(:permissions, permissions)
  end
end
