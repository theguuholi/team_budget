alias TeamBudget.Accounts.Data.User
alias TeamBudget.Members.Data.Member
alias TeamBudget.Permissions.Data.Permission
alias TeamBudget.Roles.Data.Role
alias TeamBudget.Repo

send_invites =
  Permission.changeset(%Permission{}, %{
    name: "Send Invites",
    description: "Allows your to send invites to other people"
  })
  |> Repo.insert!()

create_project =
  Permission.changeset(%Permission{}, %{
    name: "Create Project",
    description: "Allows your to create projects"
  })
  |> Repo.insert!()

admin =
  Role.changeset(%Role{}, %{
    name: "Admin",
    description: "Allows your to do everything"
  })
  |> Repo.insert!()
  |> Repo.preload(:permissions)
  |> Role.insert_permissions([create_project, send_invites])
  |> Repo.update!()

moderator =
  Role.changeset(%Role{}, %{
    name: "Moderator",
    description: "Allows your only create projects"
  })
  |> Repo.insert!()
  |> Repo.preload(:permissions)
  |> Role.insert_permissions([create_project])
  |> Repo.update!()

Role.changeset(%Role{}, %{
  name: "guest",
  description: "You can do nothing"
})
|> Repo.insert!()

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
|> Repo.insert!()
|> Repo.preload(:roles)
|> Member.insert_roles([admin])
|> Repo.update!()

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

%Member{user_id: u2.id, team_id: team_id}
|> Repo.insert!()
|> Repo.preload(:permissions)
|> Member.insert_permissions([send_invites])
|> Repo.update!()
