defmodule TeamBudget.Accounts.Core.TeamRepo do
  import Ecto.Query

  alias TeamBudget.Projects.Data.Project
  alias TeamBudget.Teams.Data.Team
  alias TeamBudget.Repo

  def list_teams(user_id) do
    query =
      from t in Team,
        left_join: p in Project,
        on: p.team_id == t.id,
        group_by: [t.id],
        where: t.user_id == ^user_id,
        select: %Team{t | total_budget: p.budget |> sum() |> coalesce("0")}

    Repo.all(query)
  end

  def get_team_by_user_and_slug(user_id, slug) do
    Repo.get_by(Team, slug: slug, user_id: user_id)
  end
end
