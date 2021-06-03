defmodule TeamBudget.Accounts do
  alias TeamBudget.Accounts.Core.UserRepo
  alias TeamBudget.Accounts.Core.CreateUser

  def list_users() do
    UserRepo.list_users()
  end

  def create_user(user) do
    CreateUser.execute(user)
  end
end
