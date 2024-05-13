defmodule Jira.ProjectPermissionSchemes do
  @moduledoc """
  Provides API endpoints related to project permission schemes
  """

  @default_client Jira.Client

  @doc """
  Assign permission scheme

  Assigns a permission scheme with a project. See [Managing project permissions](https://confluence.atlassian.com/x/yodKLg) for more information about permission schemes.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg)

  ## Options

    * `expand`: Use [expand](#expansion) to include additional information in the response. This parameter accepts a comma-separated list. Note that permissions are included when you specify any value. Expand options include:
      
       *  `all` Returns all expandable information.
       *  `field` Returns information about the custom field granted the permission.
       *  `group` Returns information about the group that is granted the permission.
       *  `permissions` Returns all permission grants for each permission scheme.
       *  `projectRole` Returns information about the project role granted the permission.
       *  `user` Returns information about the user who is granted the permission.

  """
  @spec assign_permission_scheme(String.t(), Jira.IdBean.t(), keyword) ::
          {:ok, Jira.PermissionScheme.t()} | :error
  def assign_permission_scheme(projectKeyOrId, body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:expand])

    client.request(%{
      args: [projectKeyOrId: projectKeyOrId, body: body],
      call: {Jira.ProjectPermissionSchemes, :assign_permission_scheme},
      url: "/rest/api/2/project/#{projectKeyOrId}/permissionscheme",
      body: body,
      method: :put,
      query: query,
      request: [{"application/json", {Jira.IdBean, :t}}],
      response: [{200, {Jira.PermissionScheme, :t}}, {401, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get assigned permission scheme

  Gets the [permission scheme](https://confluence.atlassian.com/x/yodKLg) associated with the project.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg) or *Administer projects* [project permission](https://confluence.atlassian.com/x/yodKLg).

  ## Options

    * `expand`: Use [expand](#expansion) to include additional information in the response. This parameter accepts a comma-separated list. Note that permissions are included when you specify any value. Expand options include:
      
       *  `all` Returns all expandable information.
       *  `field` Returns information about the custom field granted the permission.
       *  `group` Returns information about the group that is granted the permission.
       *  `permissions` Returns all permission grants for each permission scheme.
       *  `projectRole` Returns information about the project role granted the permission.
       *  `user` Returns information about the user who is granted the permission.

  """
  @spec get_assigned_permission_scheme(String.t(), keyword) ::
          {:ok, Jira.PermissionScheme.t()} | :error
  def get_assigned_permission_scheme(projectKeyOrId, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:expand])

    client.request(%{
      args: [projectKeyOrId: projectKeyOrId],
      call: {Jira.ProjectPermissionSchemes, :get_assigned_permission_scheme},
      url: "/rest/api/2/project/#{projectKeyOrId}/permissionscheme",
      method: :get,
      query: query,
      response: [{200, {Jira.PermissionScheme, :t}}, {401, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get project issue security scheme

  Returns the [issue security scheme](https://confluence.atlassian.com/x/J4lKLg) associated with the project.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg) or the *Administer Projects* [project permission](https://confluence.atlassian.com/x/yodKLg).
  """
  @spec get_project_issue_security_scheme(String.t(), keyword) ::
          {:ok, Jira.SecurityScheme.t()} | :error
  def get_project_issue_security_scheme(projectKeyOrId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [projectKeyOrId: projectKeyOrId],
      call: {Jira.ProjectPermissionSchemes, :get_project_issue_security_scheme},
      url: "/rest/api/2/project/#{projectKeyOrId}/issuesecuritylevelscheme",
      method: :get,
      response: [
        {200, {Jira.SecurityScheme, :t}},
        {400, :null},
        {401, :null},
        {403, :null},
        {404, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Get project issue security levels

  Returns all [issue security](https://confluence.atlassian.com/x/J4lKLg) levels for the project that the user has access to.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** *Browse projects* [global permission](https://confluence.atlassian.com/x/x4dKLg) for the project, however, issue security levels are only returned for authenticated user with *Set Issue Security* [global permission](https://confluence.atlassian.com/x/x4dKLg) for the project.
  """
  @spec get_security_levels_for_project(String.t(), keyword) ::
          {:ok, Jira.ProjectIssueSecurityLevels.t()} | :error
  def get_security_levels_for_project(projectKeyOrId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [projectKeyOrId: projectKeyOrId],
      call: {Jira.ProjectPermissionSchemes, :get_security_levels_for_project},
      url: "/rest/api/2/project/#{projectKeyOrId}/securitylevel",
      method: :get,
      response: [{200, {Jira.ProjectIssueSecurityLevels, :t}}, {404, :null}],
      opts: opts
    })
  end
end
