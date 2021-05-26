defmodule TeamBudgetGraphql.Types.Role do
  use Absinthe.Schema.Notation

  object :role do
    field :id, :string
    field :description, :string
    field :name, :string
    field :slug, :string
  end

  input_object :role_input do
    field :description, non_null(:string)
    field :name, non_null(:string)
  end
end
