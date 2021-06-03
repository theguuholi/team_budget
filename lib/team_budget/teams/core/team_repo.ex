defmodule TeamBudget.Accounts.Core.TeamRepo do
  import Ecto.Query

  alias TeamBudget.Projects.Data.Project
  alias TeamBudget.Teams.Data.Team
  alias TeamBudget.Members.Data.Member
  alias TeamBudget.Roles.Data.Role
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

  def create_team(team, user_id) do
    team
    |> associate_logged_user_with_team(user_id)
    |> create_transaction_process()
    |> create_transaction_team()
    |> insert_logged_user_as_member(user_id)
    |> insert_member_as_admin()
    |> execute_transaction()
    |> build_response()
  end

  defp associate_logged_user_with_team(team, user_id) do
    Map.put(team, :user_id, user_id)
  end

  defp create_transaction_process(team) do
    {team, Ecto.Multi.new()}
  end

  defp create_transaction_team({team, multi}) do
    Ecto.Multi.insert(multi, :create_team, Team.changeset(team))
  end

  defp insert_logged_user_as_member(multi, user_id) do
    Ecto.Multi.insert(multi, :insert_user_as_member, fn %{create_team: team} ->
      Member.changeset(%{user_id: user_id, team_id: team.id})
    end)
  end

  defp insert_member_as_admin(multi) do
    Ecto.Multi.update(multi, :insert_member_as_admin, fn %{insert_user_as_member: member} ->
      admin = Repo.get_by!(Role, slug: "admin")

      member
      |> Repo.preload(:roles)
      |> Member.insert_roles([admin])
    end)
  end

  defp execute_transaction(multi) do
    Repo.transaction(multi)
  end

  defp build_response({:ok, %{create_team: team}}) do
    {:ok, team}
  end

  defp build_response({:error, :create_team, changeset, _}) do
    {:error, changeset}
  end
end
