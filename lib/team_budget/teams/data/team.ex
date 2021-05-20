defmodule TeamBudget.Teams.Data.Team do
  use Ecto.Schema
  import Ecto.Changeset
  alias TeamBudget.Accounts.Data.User
  alias TeamBudget.Util.CreateSlug

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "teams" do
    field :description, :string
    field :name, :string
    field :slug, :string
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(attrs \\ %{}) do
    changeset(%__MODULE__{}, attrs)
  end

  def changeset(team, attrs) do
    team
    |> cast(attrs, [:name, :slug, :description, :user_id])
    |> validate_required([:name, :description, :user_id])
    |> CreateSlug.perform(:name)
    |> unique_constraint(:name)
    |> unique_constraint(:slug)
  end
end
