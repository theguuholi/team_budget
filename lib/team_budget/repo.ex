defmodule TeamBudget.Repo do
  use Ecto.Repo,
    otp_app: :team_budget,
    adapter: Ecto.Adapters.Postgres
end
