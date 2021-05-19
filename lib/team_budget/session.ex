defmodule TeamBudget.Session do
  alias TeamBudget.Accounts.Core.Session

  def login(user) do
    Session.login(user)
  end
end
