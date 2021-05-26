defmodule TeamBudgetGraphql.Types do
  use Absinthe.Schema.Notation
  alias TeamBudgetGraphql.Types

  import_types(Types.Session)
  import_types(Types.User)
  import_types(Types.Team)
  import_types(Types.Project)
  import_types(Types.Invite)
  import_types(Types.Role)
  import_types(Types.Project)
end
