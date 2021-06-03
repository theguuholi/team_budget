defmodule TeamBudget.Invites.Core.InviteRepo do
  import Ecto.Query
  alias TeamBudget.Repo
  alias TeamBudget.Invites.Data.Invite
  alias TeamBudget.Teams.Data.Team

  def find_invites_to_a_team_by_email(email) do
    query =
      from i in Invite,
        join: t in Team,
        on: t.id == i.team_id,
        where: i.email == ^email,
        select: %{team: t, invite_id: i.id}

    Repo.all(query)
  end
end
