defmodule TeamBudgetGraphql.Schema do
  use Absinthe.Schema
  alias TeamBudgetGraphql.Middleware
  alias TeamBudgetGraphql.Resolvers
  alias TeamBudget.Teams.Data.Team

  import_types(TeamBudgetGraphql.Types)

  import AbsintheErrorPayload.Payload
  import_types(AbsintheErrorPayload.ValidationMessageTypes)

  payload_object(:user_payload, :user)
  payload_object(:login_payload, :session)
  payload_object(:project_payload, :project)
  payload_object(:role_payload, :role)
  payload_object(:permission_payload, :permission)

  query do
    @desc "Get list of all users"
    field :list_users, list_of(:user) do
      middleware(Middleware.Authorize, :user)
      resolve(&Resolvers.UserResolver.list_users/3)
    end

    @desc "Get list of all teams from an User"
    field :list_teams, list_of(:team) do
      middleware(Middleware.Authorize, :user)
      resolve(&Resolvers.TeamResolver.list_teams/3)
    end

    @desc "Get list of all members of a Team"
    field :list_members, list_of(:member) do
      arg(:team_id, non_null(:string))
      middleware(Middleware.Authorize, :user)
      resolve(&Resolvers.MemberResolver.list_members/3)
    end

    @desc "List a Project"
    field :list_projects, list_of(:project) do
      middleware(Middleware.Authorize, :user)
      middleware(Middleware.SetATeam)
      resolve(&Resolvers.ProjectResolver.list_projects/3)
    end

    @desc "List a Roles"
    field :list_roles, list_of(:role) do
      middleware(Middleware.Authorize, :user)
      resolve(&Resolvers.RoleResolver.list_roles/3)
    end

    @desc "List a Permissions"
    field :list_permissions, list_of(:permission) do
      middleware(Middleware.Authorize, :user)
      resolve(&Resolvers.PermissionResolver.list_permissions/3)
    end
  end

  mutation do
    @desc "Create a new User"
    field :create_user, :user_payload do
      arg(:user, non_null(:user_input))
      resolve(&Resolvers.UserResolver.create_user/3)
      middleware(&build_payload/2)
    end

    @desc "Send an Invite"
    field :send_invite, list_of(:invite) do
      arg(:invites, non_null(list_of(:string)))
      middleware(Middleware.Authorize, :user)
      middleware(Middleware.SetATeam)
      resolve(&Resolvers.InviteResolver.send_invite/3)
    end

    @desc "Create a Project"
    field :create_project, :project_payload do
      arg(:project, non_null(:project_input))
      middleware(Middleware.Authorize, :user)
      middleware(Middleware.SetATeam)
      resolve(&Resolvers.ProjectResolver.create_project/3)
      middleware(&build_payload/2)
    end

    @desc "Create a Role"
    field :create_role, :role_payload do
      arg(:role, non_null(:role_input))
      middleware(Middleware.Authorize, :user)
      resolve(&Resolvers.RoleResolver.create_role/3)
      middleware(&build_payload/2)
    end

    @desc "Create a Permission"
    field :create_permission, :permission_payload do
      arg(:permission, non_null(:permission_input))
      middleware(Middleware.Authorize, :user)
      resolve(&Resolvers.PermissionResolver.create_permission/3)
      middleware(&build_payload/2)
    end

    @desc "Update a Project"
    field :update_project, :project_payload do
      arg(:project, non_null(:project_input))
      arg(:id, non_null(:string))
      middleware(Middleware.Authorize, :user)
      resolve(&Resolvers.ProjectResolver.update_project/3)
      middleware(&build_payload/2)
    end

    @desc "Delete a Project"
    field :delete_project, :project_payload do
      arg(:id, non_null(:string))
      middleware(Middleware.Authorize, :user)
      resolve(&Resolvers.ProjectResolver.delete_project/3)
      middleware(&build_payload/2)
    end

    @desc "Login with an user and then return a JWT token"
    field :login, :login_payload do
      arg(:user, non_null(:login_input))
      resolve(&Resolvers.SessionResolver.login/3)
      middleware(&build_payload/2)
    end
  end

  def context(context) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(Team, Team.data())

    Map.put(context, :loader, loader)
  end

  def plugins, do: [Absinthe.Middleware.Dataloader | Absinthe.Plugin.defaults()]
end
