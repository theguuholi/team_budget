defmodule TeamBudget.Invites.Core.CreateInvite do
  alias TeamBudget.Accounts.Core.UserRepo

  def perform(invites, current_user, team) do
    invites
    |> Enum.map(fn invite ->
      user_invited = UserRepo.get_by_email(invite)

      invite = %{
        email: invite,
        user_id: current_user.id,
        team_id: team.id,
        email_has_account: (user_invited != nil && true) || false
      }

      {user_invited, invite}
    end)
    |> Enum.reduce(Ecto.Multi.new(), fn {user, invite}, multi ->
      nil
      # select count(m) from members m
      # where m.user_id = '740ff52a-3151-4873-99fc-0795367291d5'
      # and m.team_id = '4b30f001-200d-4975-92c5-4f5654b122a5';
    end)
    # email
    |> IO.inspect()

    # IO.inspect current_user #user que esta chamando
    # IO.inspect team #qual time
    # email que ta sendo passado ja possui conta

    {:ok, %{}}
  end
end
