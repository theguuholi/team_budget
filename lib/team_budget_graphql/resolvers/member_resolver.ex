defmodule TeamBudgetGraphql.Resolvers.MemberResolver do
  alias TeamBudget.Members

  def list_members(_parent, %{team_id: team_id}, _) do
    {:ok, Members.list_members(team_id)}
  end
end
