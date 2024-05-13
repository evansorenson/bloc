defmodule Jira.ProjectRoles do
  @moduledoc """
  Provides API endpoints related to project roles
  """

  @default_client Jira.Client

  @doc """
  Create project role

  Creates a new project role with no [default actors](#api-rest-api-2-resolution-get). You can use the [Add default actors to project role](#api-rest-api-2-role-id-actors-post) operation to add default actors to the project role after creating it.

  *Note that although a new project role is available to all projects upon creation, any default actors that are associated with the project role are not added to projects that existed prior to the role being created.*<

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec create_project_role(Jira.CreateUpdateRoleRequestBean.t(), keyword) ::
          {:ok, Jira.ProjectRole.t()} | :error
  def create_project_role(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jira.ProjectRoles, :create_project_role},
      url: "/rest/api/2/role",
      body: body,
      method: :post,
      request: [{"application/json", {Jira.CreateUpdateRoleRequestBean, :t}}],
      response: [
        {200, {Jira.ProjectRole, :t}},
        {400, :null},
        {401, :null},
        {403, :null},
        {409, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Delete project role

  Deletes a project role. You must specify a replacement project role if you wish to delete a project role that is in use.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `swap`: The ID of the project role that will replace the one being deleted.

  """
  @spec delete_project_role(integer, keyword) :: :ok | :error
  def delete_project_role(id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:swap])

    client.request(%{
      args: [id: id],
      call: {Jira.ProjectRoles, :delete_project_role},
      url: "/rest/api/2/role/#{id}",
      method: :delete,
      query: query,
      response: [
        {204, :null},
        {400, :null},
        {401, :null},
        {403, :null},
        {404, :null},
        {409, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Fully update project role

  Updates the project role's name and description. You must include both a name and a description in the request.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec fully_update_project_role(integer, Jira.CreateUpdateRoleRequestBean.t(), keyword) ::
          {:ok, Jira.ProjectRole.t()} | :error
  def fully_update_project_role(id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id, body: body],
      call: {Jira.ProjectRoles, :fully_update_project_role},
      url: "/rest/api/2/role/#{id}",
      body: body,
      method: :put,
      request: [{"application/json", {Jira.CreateUpdateRoleRequestBean, :t}}],
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
  Get all project roles

  Gets a list of all project roles, complete with project role details and default actors.

  ### About project roles ###

  [Project roles](https://support.atlassian.com/jira-cloud-administration/docs/manage-project-roles/) are a flexible way to to associate users and groups with projects. In Jira Cloud, the list of project roles is shared globally with all projects, but each project can have a different set of actors associated with it (unlike groups, which have the same membership throughout all Jira applications).

  Project roles are used in [permission schemes](#api-rest-api-2-permissionscheme-get), [email notification schemes](#api-rest-api-2-notificationscheme-get), [issue security levels](#api-rest-api-2-issuesecurityschemes-get), [comment visibility](#api-rest-api-2-comment-list-post), and workflow conditions.

  #### Members and actors ####

  In the Jira REST API, a member of a project role is called an *actor*. An *actor* is a group or user associated with a project role.

  Actors may be set as [default members](https://support.atlassian.com/jira-cloud-administration/docs/manage-project-roles/#Specifying-'default-members'-for-a-project-role) of the project role or set at the project level:

   *  Default actors: Users and groups that are assigned to the project role for all newly created projects. The default actors can be removed at the project level later if desired.
   *  Actors: Users and groups that are associated with a project role for a project, which may differ from the default actors. This enables you to assign a user to different roles in different projects.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec get_all_project_roles(keyword) :: {:ok, [Jira.ProjectRole.t()]} | :error
  def get_all_project_roles(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Jira.ProjectRoles, :get_all_project_roles},
      url: "/rest/api/2/role",
      method: :get,
      response: [{200, [{Jira.ProjectRole, :t}]}, {401, :null}, {403, :null}],
      opts: opts
    })
  end

  @doc """
  Get project role for project

  Returns a project role's details and actors associated with the project. The list of actors is sorted by display name.

  To check whether a user belongs to a role based on their group memberships, use [Get user](#api-rest-api-2-user-get) with the `groups` expand parameter selected. Then check whether the user keys and groups match with the actors returned for the project.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** *Administer Projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project or *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `excludeInactiveUsers`: Exclude inactive users.

  """
  @spec get_project_role(String.t(), integer, keyword) :: {:ok, Jira.ProjectRole.t()} | :error
  def get_project_role(projectIdOrKey, id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:excludeInactiveUsers])

    client.request(%{
      args: [projectIdOrKey: projectIdOrKey, id: id],
      call: {Jira.ProjectRoles, :get_project_role},
      url: "/rest/api/2/project/#{projectIdOrKey}/role/#{id}",
      method: :get,
      query: query,
      response: [{200, {Jira.ProjectRole, :t}}, {400, :null}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get project role by ID

  Gets the project role details and the default actors associated with the role. The list of default actors is sorted by display name.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec get_project_role_by_id(integer, keyword) :: {:ok, Jira.ProjectRole.t()} | :error
  def get_project_role_by_id(id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id],
      call: {Jira.ProjectRoles, :get_project_role_by_id},
      url: "/rest/api/2/role/#{id}",
      method: :get,
      response: [{200, {Jira.ProjectRole, :t}}, {401, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get project role details

  Returns all [project roles](https://support.atlassian.com/jira-cloud-administration/docs/manage-project-roles/) and the details for each role. Note that the list of project roles is common to all projects.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg) or *Administer projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project.

  ## Options

    * `currentMember`: Whether the roles should be filtered to include only those the user is assigned to.
    * `excludeConnectAddons`

  """
  @spec get_project_role_details(String.t(), keyword) ::
          {:ok, [Jira.ProjectRoleDetails.t()]} | :error
  def get_project_role_details(projectIdOrKey, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:currentMember, :excludeConnectAddons])

    client.request(%{
      args: [projectIdOrKey: projectIdOrKey],
      call: {Jira.ProjectRoles, :get_project_role_details},
      url: "/rest/api/2/project/#{projectIdOrKey}/roledetails",
      method: :get,
      query: query,
      response: [{200, [{Jira.ProjectRoleDetails, :t}]}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @type get_project_roles_200_json_resp :: %{}

  @doc """
  Get project roles for project

  Returns a list of [project roles](https://support.atlassian.com/jira-cloud-administration/docs/manage-project-roles/) for the project returning the name and self URL for each role.

  Note that all project roles are shared with all projects in Jira Cloud. See [Get all project roles](#api-rest-api-2-role-get) for more information.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** *Administer Projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for any project on the site or *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec get_project_roles(String.t(), keyword) :: {:ok, map} | :error
  def get_project_roles(projectIdOrKey, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [projectIdOrKey: projectIdOrKey],
      call: {Jira.ProjectRoles, :get_project_roles},
      url: "/rest/api/2/project/#{projectIdOrKey}/role",
      method: :get,
      response: [
        {200, {Jira.ProjectRoles, :get_project_roles_200_json_resp}},
        {401, :null},
        {404, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Partial update project role

  Updates either the project role's name or its description.

  You cannot update both the name and description at the same time using this operation. If you send a request with a name and a description only the name is updated.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec partial_update_project_role(integer, Jira.CreateUpdateRoleRequestBean.t(), keyword) ::
          {:ok, Jira.ProjectRole.t()} | :error
  def partial_update_project_role(id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id, body: body],
      call: {Jira.ProjectRoles, :partial_update_project_role},
      url: "/rest/api/2/role/#{id}",
      body: body,
      method: :post,
      request: [{"application/json", {Jira.CreateUpdateRoleRequestBean, :t}}],
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

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(:get_project_roles_200_json_resp) do
    []
  end
end
