defmodule TeamBudgetGraphql.Types do
  use Absinthe.Schema.Notation
  alias TeamBudgetGraphql.Types

  import_types(Types.User)
end
