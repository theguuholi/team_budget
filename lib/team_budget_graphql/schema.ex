defmodule TeamBudgetGraphql.Schema do
  use Absinthe.Schema
  alias TeamBudgetGraphql.Resolvers

  import_types(TeamBudgetGraphql.Types)

  query do
    @desc "Get list of all users"
    field :list_users, list_of(:user) do
      resolve(&Resolvers.UserResolver.list_users/3)
    end
  end

  # mutation do
  # end
end
