defmodule TeamBudgetGraphql.Types.Permission do
  use Absinthe.Schema.Notation

  object :permission do
    field :id, :string
    field :description, :string
    field :name, :string
    field :slug, :string
  end

  input_object :permission_input do
    field :description, non_null(:string)
    field :name, non_null(:string)
  end
end
