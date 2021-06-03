defmodule TeamBudget.Accounts.Core.CreateUser do
  alias TeamBudget.Invites.Core.InviteRepo
  alias TeamBudget.Accounts.Data.User
  alias TeamBudget.Members.Data.Member
  alias TeamBudget.Invites.Data.Invite
  import Ecto.Query
  alias TeamBudget.Repo

  def execute(user) do
    teams = InviteRepo.find_invites_to_a_team_by_email(user.email)

    case teams do
      [] ->
        {:error, "You don`t have invite to join any team"}

      team_and_invites ->
        user
        |> insert_user()
        |> include_user_as_a_member_in_a_team(team_and_invites)
        |> delete_invites()
        |> execute_transaction()
        |> build_response()
    end
  end

  def insert_user(user) do
    Ecto.Multi.insert(Ecto.Multi.new(), :user, User.changeset(user))
  end

  defp include_user_as_a_member_in_a_team(multi, team_and_invites) do
    multi =
      Ecto.Multi.insert_all(multi, :include_user_as_member, Member, fn %{user: user} ->
        Enum.map(
          team_and_invites,
          &%{
            user_id: user.id,
            team_id: &1.team.id,
            inserted_at: build_date(),
            updated_at: build_date()
          }
        )
      end)

    {multi, team_and_invites}
  end

  defp build_date(), do: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)

  defp delete_invites({multi, team_and_invites}) do
    Ecto.Multi.delete_all(multi, :delete_invites, fn _ ->
      invites = Enum.map(team_and_invites, & &1.invite_id)
      from i in Invite, where: i.id in ^invites
    end)
  end

  defp execute_transaction(multi) do
    Repo.transaction(multi)
  end

  defp build_response({:ok, %{user: user}}), do: {:ok, user}
  defp build_response({:error, :user, changeset, _}), do: {:error, changeset}
end
