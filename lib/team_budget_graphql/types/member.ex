defmodule TeamBudgetGraphql.Types.Member do
  use Absinthe.Schema.Notation

  object :member do
    field :id, :string
    field :user_id, :string
    field :team_id, :string
    field :user, :user
    field :team, :team
    field :roles, list_of(:role)
    field :permissions, list_of(:permission)
  end
end
