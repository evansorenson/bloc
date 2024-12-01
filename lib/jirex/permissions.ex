defmodule Jirex.Permissions do
  @moduledoc """
  Provides API endpoints related to permissions
  """

  @default_client Jirex.Client

  @doc """
  Get all permissions

  Returns all permissions, including:

   *  global permissions.
   *  project permissions.
   *  global permissions added by plugins.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** None.
  """
  @spec get_all_permissions(keyword) :: {:ok, Jirex.Permissions.t()} | :error
  def get_all_permissions(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Jirex.Permissions, :get_all_permissions},
      url: "/rest/api/2/permissions",
      method: :get,
      response: [{200, {Jirex.Permissions, :t}}, {401, :null}, {403, :null}],
      opts: opts
    })
  end

  @doc """
  Get bulk permissions

  Returns:

   *  for a list of global permissions, the global permissions granted to a user.
   *  for a list of project permissions and lists of projects and issues, for each project permission a list of the projects and issues a user can access or manipulate.

  If no account ID is provided, the operation returns details for the logged in user.

  Note that:

   *  Invalid project and issue IDs are ignored.
   *  A maximum of 1000 projects and 1000 issues can be checked.
   *  Null values in `globalPermissions`, `projectPermissions`, `projectPermissions.projects`, and `projectPermissions.issues` are ignored.
   *  Empty strings in `projectPermissions.permissions` are ignored.

  **Deprecation notice:** The required OAuth 2.0 scopes will be updated on June 15, 2024.

   *  **Classic**: `read:jira-work`
   *  **Granular**: `read:permission:jira`

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg) to check the permissions for other users, otherwise none. However, Connect apps can make a call from the app server to the product to obtain permission details for any user, without admin permission. This Connect app ability doesn't apply to calls made using AP.request(%{}) in a browser.
  """
  @spec get_bulk_permissions(Jirex.BulkPermissionsRequestBean.t(), keyword) ::
          {:ok, Jirex.BulkPermissionGrants.t()} | {:error, Jirex.ErrorCollection.t()}
  def get_bulk_permissions(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jirex.Permissions, :get_bulk_permissions},
      url: "/rest/api/2/permissions/check",
      body: body,
      method: :post,
      request: [{"application/json", {Jirex.BulkPermissionsRequestBean, :t}}],
      response: [
        {200, {Jirex.BulkPermissionGrants, :t}},
        {400, {Jirex.ErrorCollection, :t}},
        {403, {Jirex.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get my permissions

  Returns a list of permissions indicating which permissions the user has. Details of the user's permissions can be obtained in a global, project, issue or comment context.

  The user is reported as having a project permission:

   *  in the global context, if the user has the project permission in any project.
   *  for a project, where the project permission is determined using issue data, if the user meets the permission's criteria for any issue in the project. Otherwise, if the user has the project permission in the project.
   *  for an issue, where a project permission is determined using issue data, if the user has the permission in the issue. Otherwise, if the user has the project permission in the project containing the issue.
   *  for a comment, where the user has both the permission to browse the comment and the project permission for the comment's parent issue. Only the BROWSE\_PROJECTS permission is supported. If a `commentId` is provided whose `permissions` does not equal BROWSE\_PROJECTS, a 400 error will be returned.

  This means that users may be shown as having an issue permission (such as EDIT\_ISSUES) in the global context or a project context but may not have the permission for any or all issues. For example, if Reporters have the EDIT\_ISSUES permission a user would be shown as having this permission in the global context or the context of a project, because any user can be a reporter. However, if they are not the user who reported the issue queried they would not have EDIT\_ISSUES permission for that issue.

  Global permissions are unaffected by context.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** None.

  ## Options

    * `projectKey`: The key of project. Ignored if `projectId` is provided.
    * `projectId`: The ID of project.
    * `issueKey`: The key of the issue. Ignored if `issueId` is provided.
    * `issueId`: The ID of the issue.
    * `permissions`: A list of permission keys. (Required) This parameter accepts a comma-separated list. To get the list of available permissions, use [Get all permissions](#api-rest-api-2-permissions-get).
    * `projectUuid`
    * `projectConfigurationUuid`
    * `commentId`: The ID of the comment.

  """
  @spec get_my_permissions(keyword) ::
          {:ok, Jirex.Permissions.t()} | {:error, Jirex.ErrorCollection.t()}
  def get_my_permissions(opts \\ []) do
    client = opts[:client] || @default_client

    query =
      Keyword.take(opts, [
        :commentId,
        :issueId,
        :issueKey,
        :permissions,
        :projectConfigurationUuid,
        :projectId,
        :projectKey,
        :projectUuid
      ])

    client.request(%{
      args: [],
      call: {Jirex.Permissions, :get_my_permissions},
      url: "/rest/api/2/mypermissions",
      method: :get,
      query: query,
      response: [
        {200, {Jirex.Permissions, :t}},
        {400, {Jirex.ErrorCollection, :t}},
        {401, {Jirex.ErrorCollection, :t}},
        {404, {Jirex.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get permitted projects

  Returns all the projects where the user is granted a list of project permissions.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** None.
  """
  @spec get_permitted_projects(Jirex.PermissionsKeysBean.t(), keyword) ::
          {:ok, Jirex.PermittedProjects.t()} | :error
  def get_permitted_projects(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jirex.Permissions, :get_permitted_projects},
      url: "/rest/api/2/permissions/project",
      body: body,
      method: :post,
      request: [{"application/json", {Jirex.PermissionsKeysBean, :t}}],
      response: [{200, {Jirex.PermittedProjects, :t}}, {400, :null}, {401, :null}],
      opts: opts
    })
  end

  @type t :: %__MODULE__{permissions: Jirex.PermissionsPermissions.t() | nil}

  defstruct [:permissions]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [permissions: {Jirex.PermissionsPermissions, :t}]
  end
end
