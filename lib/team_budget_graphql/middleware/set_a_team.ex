defmodule TeamBudgetGraphql.Middleware.SetATeam do
  @behaviour Absinthe.Middleware

  def call(resolution, _p) do
    if Map.get(resolution.context, :team) |> is_nil do
      Absinthe.Resolution.put_result(resolution, {:error, "Please choose a valid slug team"})
    else
      resolution
    end
  end
end
