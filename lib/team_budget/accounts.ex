defmodule TeamBudget.Accounts do
  alias TeamBudget.Accounts.User
  alias TeamBudget.Repo

  def list_users() do
    Repo.all(User)
  end
end
