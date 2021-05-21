defmodule TeamBudget.Members.Core.MembersRepo do
  import Ecto.Query
  alias TeamBudget.Members.Data.Member
  alias TeamBudget.Repo

  def user_is_member_from_a_team?(user_id, team_id) do
    query =
      from(m in Member,
        where: m.user_id == ^user_id and m.team_id == ^team_id,
        select: count(m.id)
      )

    [count] = Repo.all(query)
    (count > 0 && true) || false
  end
end
