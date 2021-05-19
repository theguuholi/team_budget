defmodule TeamBudget.Accounts.Core.UserRepo do
  alias TeamBudget.Accounts.User
  alias TeamBudget.Repo

  def list_users() do
    Repo.all(User)
  end

  def get_user(id), do: Repo.get(User, id)

  def create_user(user) do
    user
    |> User.changeset()
    |> Repo.insert()
  end

  def get_by_email(email), do: Repo.get_by(User, email: email)
end
