defmodule TeamBudget.Members do
  import Ecto.Query
  alias TeamBudget.Repo
  alias TeamBudget.Members.Data.Member

  def list_members(team_id) do
    query =
      from m in Member,
        where: m.team_id == ^team_id,
        preload: [:user, :team, :roles, :permissions]

    Repo.all(query)
  end
end
