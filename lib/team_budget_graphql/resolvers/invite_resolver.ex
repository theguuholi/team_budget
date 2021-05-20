defmodule TeamBudgetGraphql.Resolvers.InviteResolver do
  def send_invite(_parent, params, _resolution) do
    IO.inspect(params)
    {:ok, %{}}
  end
end
