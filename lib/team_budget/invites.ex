defmodule TeamBudget.Invites do
  alias TeamBudget.Invites.Core.CreateInvite

  def send_invite(invites, current_user, team) do
    invites = CreateInvite.perform(invites, current_user, team)
    # envio de emails
    invites
  end
end
