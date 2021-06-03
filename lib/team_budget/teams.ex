defmodule TeamBudget.Teams do
  alias TeamBudget.Teams.Core.CreateTeam
  alias TeamBudget.Accounts.Core.TeamRepo

  def create_team(team, user_id) do
    CreateTeam.execute(team, user_id)
  end

  def list_teams(user_id) do
    TeamRepo.list_teams(user_id)
  end
end
