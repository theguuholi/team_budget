defmodule TeamBudget.Invites.Server.SendEmail do
  import Bamboo.Email
  alias TeamBudget.Mailer

  def perform({:ok, invites}) do
    Enum.each(invites, &send_email/1)
  end

  defp send_email(invite) do
    Task.async(fn ->
      new_email()
      |> from({"Elxpro TeamBudget", "adm@elxpro.com"})
      |> to(invite.email)
      |> subject("[ELXPRO TeamBudget] - You were invited to join to a team #{invite.team.slug}")
      |> create_email_based_if_user_has_account(invite, invite.email_has_account)
      |> Mailer.deliver_now()
    end)
  end

  defp create_email_based_if_user_has_account(email, invite, true) do
    html_body(email, """
    You were invited to join to a Team called #{invite.team.name} - (#{invite.team.slug})
    by #{invite.user.email}
    <p>To create your account please use apis with GraphQl</p>
    """)
  end

  defp create_email_based_if_user_has_account(email, invite, false) do
    html_body(email, """
    You were invited to join to a Team called #{invite.team.name} - (#{invite.team.slug})
    by #{invite.user.email}
    """)
  end
end
