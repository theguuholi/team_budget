defmodule TeamBudget.Projects.Data.Project do
  use Ecto.Schema
  import Ecto.Changeset
  alias TeamBudget.Teams.Data.Team
  alias TeamBudget.Util.CreateSlug

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "projects" do
    field :budget, :decimal
    field :description, :string
    field :name, :string
    field :slug, :string
    belongs_to :team, Team

    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:name, :description, :slug, :budget])
    |> validate_required([:name, :description, :budget])
    |> CreateSlug.perform(:name)
    |> unique_constraint(:name)
    |> unique_constraint(:slug)
  end
end
