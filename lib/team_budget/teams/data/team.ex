defmodule TeamBudget.Teams.Data.Team do
  use Ecto.Schema
  import Ecto.Changeset
  alias TeamBudget.Accounts.Data.User
  alias TeamBudget.Members.Member
  alias TeamBudget.Util.CreateSlug
  alias TeamBudget.Projects.Data.Project

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "teams" do
    field :description, :string
    field :name, :string
    field :slug, :string
    belongs_to :user, User
    has_many :projects, Project
    many_to_many :members, User, join_through: Member, on_replace: :delete

    timestamps()
  end

  def data, do: Dataloader.Ecto.new(TeamBudget.Repo, query: &query/2)

  def query(queryable, _params), do: queryable

  @doc false
  def changeset(attrs \\ %{}) do
    changeset(%__MODULE__{}, attrs)
  end

  def changeset(team, attrs) do
    team
    |> cast(attrs, [:name, :slug, :description, :user_id])
    |> validate_required([:name, :description])
    |> CreateSlug.perform(:name)
    |> unique_constraint(:name)
    |> unique_constraint(:slug)
    |> cast_assoc(:projects, with: &Project.changeset/2)
  end
end
