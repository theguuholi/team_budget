defmodule TeamBudget.Invites do
  alias TeamBudget.Invites.Core.CreateInvite

  def send_invite(invites, current_user, team) do
    CreateInvite.perform(invites, current_user, team)
  end
end
