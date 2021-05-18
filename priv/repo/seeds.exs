alias TeamBudget.{Accounts.User, Repo}

%{first_name: "Gustavo", last_name: "Oliveira", email: "t1@elxpro.com", password_hash: "123123"}
|> User.changeset()
|> Repo.insert()

%{first_name: "Test1", last_name: "1Test", email: "t2@elxpro.com", password_hash: "123123"}
|> User.changeset()
|> Repo.insert()
