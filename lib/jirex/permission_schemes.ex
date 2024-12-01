defmodule Jirex.PermissionSchemes do
  @moduledoc """
  Provides API endpoints related to permission schemes
  """

  @default_client Jirex.Client

  @doc """
  Create permission grant

  Creates a permission grant in a permission scheme.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `expand`: Use expand to include additional information in the response. This parameter accepts a comma-separated list. Note that permissions are always included when you specify any value. Expand options include:

       *  `permissions` Returns all permission grants for each permission scheme.
       *  `user` Returns information about the user who is granted the permission.
       *  `group` Returns information about the group that is granted the permission.
       *  `projectRole` Returns information about the project role granted the permission.
       *  `field` Returns information about the custom field granted the permission.
       *  `all` Returns all expandable information.

  """
  @spec create_permission_grant(integer, Jirex.PermissionGrant.t(), keyword) ::
          {:ok, Jirex.PermissionGrant.t()} | :error
  def create_permission_grant(schemeId, body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:expand])

    client.request(%{
      args: [schemeId: schemeId, body: body],
      call: {Jirex.PermissionSchemes, :create_permission_grant},
      url: "/rest/api/2/permissionscheme/#{schemeId}/permission",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Jirex.PermissionGrant, :t}}],
      response: [{201, {Jirex.PermissionGrant, :t}}, {400, :null}, {401, :null}, {403, :null}],
      opts: opts
    })
  end

  @doc """
  Create permission scheme

  Creates a new permission scheme. You can create a permission scheme with or without defining a set of permission grants.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `expand`: Use expand to include additional information in the response. This parameter accepts a comma-separated list. Note that permissions are always included when you specify any value. Expand options include:

       *  `all` Returns all expandable information.
       *  `field` Returns information about the custom field granted the permission.
       *  `group` Returns information about the group that is granted the permission.
       *  `permissions` Returns all permission grants for each permission scheme.
       *  `projectRole` Returns information about the project role granted the permission.
       *  `user` Returns information about the user who is granted the permission.

  """
  @spec create_permission_scheme(Jirex.PermissionScheme.t(), keyword) ::
          {:ok, Jirex.PermissionScheme.t()} | :error
  def create_permission_scheme(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:expand])

    client.request(%{
      args: [body: body],
      call: {Jirex.PermissionSchemes, :create_permission_scheme},
      url: "/rest/api/2/permissionscheme",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Jirex.PermissionScheme, :t}}],
      response: [{201, {Jirex.PermissionScheme, :t}}, {400, :null}, {401, :null}, {403, :null}],
      opts: opts
    })
  end

  @doc """
  Delete permission scheme

  Deletes a permission scheme.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec delete_permission_scheme(integer, keyword) :: :ok | :error
  def delete_permission_scheme(schemeId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [schemeId: schemeId],
      call: {Jirex.PermissionSchemes, :delete_permission_scheme},
      url: "/rest/api/2/permissionscheme/#{schemeId}",
      method: :delete,
      response: [{204, :null}, {401, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Delete permission scheme grant

  Deletes a permission grant from a permission scheme. See [About permission schemes and grants](../api-group-permission-schemes/#about-permission-schemes-and-grants) for more details.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec delete_permission_scheme_entity(integer, integer, keyword) :: :ok | :error
  def delete_permission_scheme_entity(schemeId, permissionId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [schemeId: schemeId, permissionId: permissionId],
      call: {Jirex.PermissionSchemes, :delete_permission_scheme_entity},
      url: "/rest/api/2/permissionscheme/#{schemeId}/permission/#{permissionId}",
      method: :delete,
      response: [{204, :null}, {400, :null}, {401, :null}, {403, :null}],
      opts: opts
    })
  end

  @doc """
  Get all permission schemes

  Returns all permission schemes.

  ### About permission schemes and grants ###

  A permission scheme is a collection of permission grants. A permission grant consists of a `holder` and a `permission`.

  #### Holder object ####

  The `holder` object contains information about the user or group being granted the permission. For example, the *Administer projects* permission is granted to a group named *Teams in space administrators*. In this case, the type is `"type": "group"`, and the parameter is the group name, `"parameter": "Teams in space administrators"` and the value is group ID, `"value": "ca85fac0-d974-40ca-a615-7af99c48d24f"`.

  The `holder` object is defined by the following properties:

   *  `type` Identifies the user or group (see the list of types below).
   *  `parameter` As a group's name can change, use of `value` is recommended. The value of this property depends on the `type`. For example, if the `type` is a group, then you need to specify the group name.
   *  `value` The value of this property depends on the `type`. If the `type` is a group, then you need to specify the group ID. For other `type` it has the same value as `parameter`

  The following `types` are available. The expected values for `parameter` and `value` are given in parentheses (some types may not have a `parameter` or `value`):

   *  `anyone` Grant for anonymous users.
   *  `applicationRole` Grant for users with access to the specified application (application name, application name). See [Update product access settings](https://confluence.atlassian.com/x/3YxjL) for more information.
   *  `assignee` Grant for the user currently assigned to an issue.
   *  `group` Grant for the specified group (`parameter` : group name, `value` : group ID).
   *  `groupCustomField` Grant for a user in the group selected in the specified custom field (`parameter` : custom field ID, `value` : custom field ID).
   *  `projectLead` Grant for a project lead.
   *  `projectRole` Grant for the specified project role (`parameter` :project role ID, `value` : project role ID).
   *  `reporter` Grant for the user who reported the issue.
   *  `sd.customer.portal.only` Jira Service Desk only. Grants customers permission to access the customer portal but not Jira. See [Customizing Jira Service Desk permissions](https://confluence.atlassian.com/x/24dKLg) for more information.
   *  `user` Grant for the specified user (`parameter` : user ID - historically this was the userkey but that is deprecated and the account ID should be used, `value` : user ID).
   *  `userCustomField` Grant for a user selected in the specified custom field (`parameter` : custom field ID, `value` : custom field ID).

  #### Built-in permissions ####

  The [built-in Jira permissions](https://confluence.atlassian.com/x/yodKLg) are listed below. Apps can also define custom permissions. See the [project permission](https://developer.atlassian.com/cloud/jira/platform/modules/project-permission/) and [global permission](https://developer.atlassian.com/cloud/jira/platform/modules/global-permission/) module documentation for more information.

  **Project permissions**

   *  `ADMINISTER_PROJECTS`
   *  `BROWSE_PROJECTS`
   *  `MANAGE_SPRINTS_PERMISSION` (Jira Software only)
   *  `SERVICEDESK_AGENT` (Jira Service Desk only)
   *  `VIEW_DEV_TOOLS` (Jira Software only)
   *  `VIEW_READONLY_WORKFLOW`

  **Issue permissions**

   *  `ASSIGNABLE_USER`
   *  `ASSIGN_ISSUES`
   *  `CLOSE_ISSUES`
   *  `CREATE_ISSUES`
   *  `DELETE_ISSUES`
   *  `EDIT_ISSUES`
   *  `LINK_ISSUES`
   *  `MODIFY_REPORTER`
   *  `MOVE_ISSUES`
   *  `RESOLVE_ISSUES`
   *  `SCHEDULE_ISSUES`
   *  `SET_ISSUE_SECURITY`
   *  `TRANSITION_ISSUES`

  **Voters and watchers permissions**

   *  `MANAGE_WATCHERS`
   *  `VIEW_VOTERS_AND_WATCHERS`

  **Comments permissions**

   *  `ADD_COMMENTS`
   *  `DELETE_ALL_COMMENTS`
   *  `DELETE_OWN_COMMENTS`
   *  `EDIT_ALL_COMMENTS`
   *  `EDIT_OWN_COMMENTS`

  **Attachments permissions**

   *  `CREATE_ATTACHMENTS`
   *  `DELETE_ALL_ATTACHMENTS`
   *  `DELETE_OWN_ATTACHMENTS`

  **Time tracking permissions**

   *  `DELETE_ALL_WORKLOGS`
   *  `DELETE_OWN_WORKLOGS`
   *  `EDIT_ALL_WORKLOGS`
   *  `EDIT_OWN_WORKLOGS`
   *  `WORK_ON_ISSUES`

  **[Permissions](#permissions) required:** Permission to access Jira.

  ## Options

    * `expand`: Use expand to include additional information in the response. This parameter accepts a comma-separated list. Note that permissions are included when you specify any value. Expand options include:

       *  `all` Returns all expandable information.
       *  `field` Returns information about the custom field granted the permission.
       *  `group` Returns information about the group that is granted the permission.
       *  `permissions` Returns all permission grants for each permission scheme.
       *  `projectRole` Returns information about the project role granted the permission.
       *  `user` Returns information about the user who is granted the permission.

  """
  @spec get_all_permission_schemes(keyword) :: {:ok, map} | :error
  def get_all_permission_schemes(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:expand])

    client.request(%{
      args: [],
      call: {Jirex.PermissionSchemes, :get_all_permission_schemes},
      url: "/rest/api/2/permissionscheme",
      method: :get,
      query: query,
      response: [{200, {Jirex.PermissionSchemes, :t}}, {401, :null}],
      opts: opts
    })
  end

  @doc """
  Get permission scheme

  Returns a permission scheme.

  **[Permissions](#permissions) required:** Permission to access Jira.

  ## Options

    * `expand`: Use expand to include additional information in the response. This parameter accepts a comma-separated list. Note that permissions are included when you specify any value. Expand options include:

       *  `all` Returns all expandable information.
       *  `field` Returns information about the custom field granted the permission.
       *  `group` Returns information about the group that is granted the permission.
       *  `permissions` Returns all permission grants for each permission scheme.
       *  `projectRole` Returns information about the project role granted the permission.
       *  `user` Returns information about the user who is granted the permission.

  """
  @spec get_permission_scheme(integer, keyword) :: {:ok, Jirex.PermissionScheme.t()} | :error
  def get_permission_scheme(schemeId, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:expand])

    client.request(%{
      args: [schemeId: schemeId],
      call: {Jirex.PermissionSchemes, :get_permission_scheme},
      url: "/rest/api/2/permissionscheme/#{schemeId}",
      method: :get,
      query: query,
      response: [{200, {Jirex.PermissionScheme, :t}}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get permission scheme grant

  Returns a permission grant.

  **[Permissions](#permissions) required:** Permission to access Jira.

  ## Options

    * `expand`: Use expand to include additional information in the response. This parameter accepts a comma-separated list. Note that permissions are always included when you specify any value. Expand options include:

       *  `all` Returns all expandable information.
       *  `field` Returns information about the custom field granted the permission.
       *  `group` Returns information about the group that is granted the permission.
       *  `permissions` Returns all permission grants for each permission scheme.
       *  `projectRole` Returns information about the project role granted the permission.
       *  `user` Returns information about the user who is granted the permission.

  """
  @spec get_permission_scheme_grant(integer, integer, keyword) ::
          {:ok, Jirex.PermissionGrant.t()} | :error
  def get_permission_scheme_grant(schemeId, permissionId, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:expand])

    client.request(%{
      args: [schemeId: schemeId, permissionId: permissionId],
      call: {Jirex.PermissionSchemes, :get_permission_scheme_grant},
      url: "/rest/api/2/permissionscheme/#{schemeId}/permission/#{permissionId}",
      method: :get,
      query: query,
      response: [{200, {Jirex.PermissionGrant, :t}}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get permission scheme grants

  Returns all permission grants for a permission scheme.

  **[Permissions](#permissions) required:** Permission to access Jira.

  ## Options

    * `expand`: Use expand to include additional information in the response. This parameter accepts a comma-separated list. Note that permissions are always included when you specify any value. Expand options include:

       *  `permissions` Returns all permission grants for each permission scheme.
       *  `user` Returns information about the user who is granted the permission.
       *  `group` Returns information about the group that is granted the permission.
       *  `projectRole` Returns information about the project role granted the permission.
       *  `field` Returns information about the custom field granted the permission.
       *  `all` Returns all expandable information.

  """
  @spec get_permission_scheme_grants(integer, keyword) ::
          {:ok, Jirex.PermissionGrants.t()} | :error
  def get_permission_scheme_grants(schemeId, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:expand])

    client.request(%{
      args: [schemeId: schemeId],
      call: {Jirex.PermissionSchemes, :get_permission_scheme_grants},
      url: "/rest/api/2/permissionscheme/#{schemeId}/permission",
      method: :get,
      query: query,
      response: [{200, {Jirex.PermissionGrants, :t}}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Update permission scheme

  Updates a permission scheme. Below are some important things to note when using this resource:

   *  If a permissions list is present in the request, then it is set in the permission scheme, overwriting *all existing* grants.
   *  If you want to update only the name and description, then do not send a permissions list in the request.
   *  Sending an empty list will remove all permission grants from the permission scheme.

  If you want to add or delete a permission grant instead of updating the whole list, see [Create permission grant](#api-rest-api-2-permissionscheme-schemeId-permission-post) or [Delete permission scheme entity](#api-rest-api-2-permissionscheme-schemeId-permission-permissionId-delete).

  See [About permission schemes and grants](../api-group-permission-schemes/#about-permission-schemes-and-grants) for more details.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `expand`: Use expand to include additional information in the response. This parameter accepts a comma-separated list. Note that permissions are always included when you specify any value. Expand options include:

       *  `all` Returns all expandable information.
       *  `field` Returns information about the custom field granted the permission.
       *  `group` Returns information about the group that is granted the permission.
       *  `permissions` Returns all permission grants for each permission scheme.
       *  `projectRole` Returns information about the project role granted the permission.
       *  `user` Returns information about the user who is granted the permission.

  """
  @spec update_permission_scheme(integer, Jirex.PermissionScheme.t(), keyword) ::
          {:ok, Jirex.PermissionScheme.t()} | :error
  def update_permission_scheme(schemeId, body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:expand])

    client.request(%{
      args: [schemeId: schemeId, body: body],
      call: {Jirex.PermissionSchemes, :update_permission_scheme},
      url: "/rest/api/2/permissionscheme/#{schemeId}",
      body: body,
      method: :put,
      query: query,
      request: [{"application/json", {Jirex.PermissionScheme, :t}}],
      response: [{200, {Jirex.PermissionScheme, :t}}, {401, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end

  @type t :: %__MODULE__{permissionSchemes: [Jirex.PermissionScheme.t()] | nil}

  defstruct [:permissionSchemes]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [permissionSchemes: [{Jirex.PermissionScheme, :t}]]
  end
end
