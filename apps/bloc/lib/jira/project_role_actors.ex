defmodule Jira.ProjectRoleActors do
  @moduledoc """
  Provides API endpoints related to project role actors
  """

  @default_client Jira.Client

  @doc """
  Add actors to project role

  Adds actors to a project role for the project.

  To replace all actors for the project, use [Set actors for project role](#api-rest-api-2-project-projectIdOrKey-role-id-put).

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** *Administer Projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project or *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec add_actor_users(String.t(), integer, Jira.ActorsMap.t(), keyword) ::
          {:ok, Jira.ProjectRole.t()} | :error
  def add_actor_users(projectIdOrKey, id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [projectIdOrKey: projectIdOrKey, id: id, body: body],
      call: {Jira.ProjectRoleActors, :add_actor_users},
      url: "/rest/api/2/project/#{projectIdOrKey}/role/#{id}",
      body: body,
      method: :post,
      request: [{"application/json", {Jira.ActorsMap, :t}}],
      response: [{200, {Jira.ProjectRole, :t}}, {400, :null}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Add default actors to project role

  Adds [default actors](#api-rest-api-2-resolution-get) to a role. You may add groups or users, but you cannot add groups and users in the same request.

  Changing a project role's default actors does not affect project role members for projects already created.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec add_project_role_actors_to_role(integer, Jira.ActorInputBean.t(), keyword) ::
          {:ok, Jira.ProjectRole.t()} | :error
  def add_project_role_actors_to_role(id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id, body: body],
      call: {Jira.ProjectRoleActors, :add_project_role_actors_to_role},
      url: "/rest/api/2/role/#{id}/actors",
      body: body,
      method: :post,
      request: [{"application/json", {Jira.ActorInputBean, :t}}],
      response: [
        {200, {Jira.ProjectRole, :t}},
        {400, :null},
        {401, :null},
        {403, :null},
        {404, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Delete actors from project role

  Deletes actors from a project role for the project.

  To remove default actors from the project role, use [Delete default actors from project role](#api-rest-api-2-role-id-actors-delete).

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** *Administer Projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project or *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `user`: The user account ID of the user to remove from the project role.
    * `group`: The name of the group to remove from the project role. This parameter cannot be used with the `groupId` parameter. As a group's name can change, use of `groupId` is recommended.
    * `groupId`: The ID of the group to remove from the project role. This parameter cannot be used with the `group` parameter.

  """
  @spec delete_actor(String.t(), integer, keyword) :: :ok | :error
  def delete_actor(projectIdOrKey, id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:group, :groupId, :user])

    client.request(%{
      args: [projectIdOrKey: projectIdOrKey, id: id],
      call: {Jira.ProjectRoleActors, :delete_actor},
      url: "/rest/api/2/project/#{projectIdOrKey}/role/#{id}",
      method: :delete,
      query: query,
      response: [{204, :null}, {400, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Delete default actors from project role

  Deletes the [default actors](#api-rest-api-2-resolution-get) from a project role. You may delete a group or user, but you cannot delete a group and a user in the same request.

  Changing a project role's default actors does not affect project role members for projects already created.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `user`: The user account ID of the user to remove as a default actor.
    * `groupId`: The group ID of the group to be removed as a default actor. This parameter cannot be used with the `group` parameter.
    * `group`: The group name of the group to be removed as a default actor.This parameter cannot be used with the `groupId` parameter. As a group's name can change, use of `groupId` is recommended.

  """
  @spec delete_project_role_actors_from_role(integer, keyword) ::
          {:ok, Jira.ProjectRole.t()} | :error
  def delete_project_role_actors_from_role(id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:group, :groupId, :user])

    client.request(%{
      args: [id: id],
      call: {Jira.ProjectRoleActors, :delete_project_role_actors_from_role},
      url: "/rest/api/2/role/#{id}/actors",
      method: :delete,
      query: query,
      response: [
        {200, {Jira.ProjectRole, :t}},
        {400, :null},
        {401, :null},
        {403, :null},
        {404, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Get default actors for project role

  Returns the [default actors](#api-rest-api-2-resolution-get) for the project role.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec get_project_role_actors_for_role(integer, keyword) :: {:ok, Jira.ProjectRole.t()} | :error
  def get_project_role_actors_for_role(id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id],
      call: {Jira.ProjectRoleActors, :get_project_role_actors_for_role},
      url: "/rest/api/2/role/#{id}/actors",
      method: :get,
      response: [
        {200, {Jira.ProjectRole, :t}},
        {400, :null},
        {401, :null},
        {403, :null},
        {404, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Set actors for project role

  Sets the actors for a project role for a project, replacing all existing actors.

  To add actors to the project without overwriting the existing list, use [Add actors to project role](#api-rest-api-2-project-projectIdOrKey-role-id-post).

  **[Permissions](#permissions) required:** *Administer Projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project or *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec set_actors(String.t(), integer, Jira.ProjectRoleActorsUpdateBean.t(), keyword) ::
          {:ok, Jira.ProjectRole.t()} | :error
  def set_actors(projectIdOrKey, id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [projectIdOrKey: projectIdOrKey, id: id, body: body],
      call: {Jira.ProjectRoleActors, :set_actors},
      url: "/rest/api/2/project/#{projectIdOrKey}/role/#{id}",
      body: body,
      method: :put,
      request: [{"application/json", {Jira.ProjectRoleActorsUpdateBean, :t}}],
      response: [{200, {Jira.ProjectRole, :t}}, {400, :null}, {401, :null}, {404, :null}],
      opts: opts
    })
  end
end
