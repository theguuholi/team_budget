defmodule TeamBudget.Invites do
  alias TeamBudget.Invites.Core.CreateInvite
  alias TeamBudget.Invites.Server.SendEmail

  def send_invite(invites, current_user, team) do
    invites = CreateInvite.perform(invites, current_user, team)
    SendEmail.perform(invites)
    invites
  end
end
