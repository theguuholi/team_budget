alias TeamBudget.{Accounts.Data.User, Members.Data.Member, Repo}

{:ok, %{id: user_id, teams: [%{id: team_id} | _]}} =
  %{
    first_name: "Gustavo",
    last_name: "Oliveira",
    email: "t1@elxpro.com",
    password: "123123",
    password_confirmation: "123123",
    teams: [
      %{name: "elxpro graphql", description: "learn more about graphql with this team"}
    ]
  }
  |> User.changeset()
  |> Repo.insert()

%Member{user_id: user_id, team_id: team_id}
|> Repo.insert()

{:ok, u2} =
  %{
    first_name: "Test1",
    last_name: "1Test",
    email: "t2@elxpro.com",
    password: "123123",
    password_confirmation: "123123"
  }
  |> User.changeset()
  |> Repo.insert()
