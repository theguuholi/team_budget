alias TeamBudget.{Accounts.Data.User, Members.Data.Member, Repo}

{:ok, %{id: user_id, teams: [%{id: team_id} | _]}} =
  %{
    first_name: "Gustavo",
    last_name: "Oliveira",
    email: "t1@elxpro.com",
    password: "123123",
    password_confirmation: "123123",
    teams: [
      %{
        name: "elxpro graphql",
        description: "learn more about graphql with this team",
        projects: [
          %{
            name: "graphQl api finance",
            description: "api to show assets durind the day",
            budget: Decimal.new("300000")
          },
          %{
            name: "liveview finance",
            description: "show assets durind the day",
            budget: Decimal.new("323002")
          }
        ]
      },
      %{name: "elxpro liveview", description: "learn more about graphql with this team"}
    ]
  }
  |> User.changeset()
  |> Repo.insert()

%Member{user_id: user_id, team_id: team_id}
|> Repo.insert()

{:ok, _u2} =
  %{
    first_name: "Test1",
    last_name: "1Test",
    email: "t2@elxpro.com",
    password: "123123",
    password_confirmation: "123123"
  }
  |> User.changeset()
  |> Repo.insert()
