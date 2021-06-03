defmodule TeamBudgetGraphql.Resolvers.TeamResolver do
  alias TeamBudget.Accounts.Core.TeamRepo

  def list_teams(_parent, _params, %{context: %{current_user: %{id: user_id}}}) do
    {:ok, TeamRepo.list_teams(user_id)}
  end

  def create_team(_, %{team: team}, %{context: %{current_user: %{id: user_id}}}) do
    TeamRepo.create_team(team, user_id)
  end
end
