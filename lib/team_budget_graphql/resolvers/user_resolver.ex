defmodule TeamBudgetGraphql.Resolvers.UserResolver do

  def list_users(_parent, _params, _resolutions) do
    {:error, "something went wrong"}
  end
end
