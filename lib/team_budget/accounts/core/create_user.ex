defmodule TeamBudget.Accounts.Core.CreateUser do
  alias TeamBudget.Invites.Core.InviteRepo
  alias TeamBudget.Accounts.Data.User

  def execute(user) do
    teams = InviteRepo.find_invites_to_a_team_by_email(user.email)

    case teams do
      [] ->
        {:error, "You don`t have invite to join any team"}

      team_and_invites ->
        user
        |> insert_user()
        |> include_user_as_a_member_in_a_team(team_and_invites)
    end
  end

  def insert_user(user) do
    Ecto.Multi.insert(Ecto.Multi.new(), :user, User.changeset(user))
  end

  defp include_user_as_a_member_in_a_team(multi, team_and_invites) do
    Ecto.Multi.insert(multi, :include_user_as_member, fn %{user: user} ->
      teams = Enum.map(team_and_invites, & &1.team)

      user
      |> Repo.preaload(:teams)
    end)
  end
end
