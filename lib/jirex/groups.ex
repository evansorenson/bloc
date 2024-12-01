defmodule Jirex.Groups do
  @moduledoc """
  Provides API endpoints related to groups
  """

  @default_client Jirex.Client

  @doc """
  Add user to group

  Adds a user to a group.

  **[Permissions](#permissions) required:** Site administration (that is, member of the *site-admin* [group](https://confluence.atlassian.com/x/24xjL)).

  ## Options

    * `groupname`: As a group's name can change, use of `groupId` is recommended to identify a group.
      The name of the group. This parameter cannot be used with the `groupId` parameter.
    * `groupId`: The ID of the group. This parameter cannot be used with the `groupName` parameter.

  """
  @spec add_user_to_group(Jirex.UpdateUserToGroupBean.t(), keyword) ::
          {:ok, Jirex.Group.t()} | :error
  def add_user_to_group(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:groupId, :groupname])

    client.request(%{
      args: [body: body],
      call: {Jirex.Groups, :add_user_to_group},
      url: "/rest/api/2/group/user",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Jirex.UpdateUserToGroupBean, :t}}],
      response: [{201, {Jirex.Group, :t}}, {400, :null}, {401, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Bulk get groups

  Returns a [paginated](#pagination) list of groups.

  **[Permissions](#permissions) required:** *Browse users and groups* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.
    * `groupId`: The ID of a group. To specify multiple IDs, pass multiple `groupId` parameters. For example, `groupId=5b10a2844c20165700ede21g&groupId=5b10ac8d82e05b22cc7d4ef5`.
    * `groupName`: The name of a group. To specify multiple names, pass multiple `groupName` parameters. For example, `groupName=administrators&groupName=jira-software-users`.
    * `accessType`: The access level of a group. Valid values: 'site-admin', 'admin', 'user'.
    * `applicationKey`: The application key of the product user groups to search for. Valid values: 'jira-servicedesk', 'jira-software', 'jira-product-discovery', 'jira-core'.

  """
  @spec bulk_get_groups(keyword) :: {:ok, Jirex.PageBeanGroupDetails.t()} | {:error, any}
  def bulk_get_groups(opts \\ []) do
    client = opts[:client] || @default_client

    query =
      Keyword.take(opts, [
        :accessType,
        :applicationKey,
        :groupId,
        :groupName,
        :maxResults,
        :startAt
      ])

    client.request(%{
      args: [],
      call: {Jirex.Groups, :bulk_get_groups},
      url: "/rest/api/2/group/bulk",
      method: :get,
      query: query,
      response: [
        {200, {Jirex.PageBeanGroupDetails, :t}},
        {400, :null},
        {401, :null},
        {403, :unknown},
        {500, :unknown}
      ],
      opts: opts
    })
  end

  @doc """
  Create group

  Creates a group.

  **[Permissions](#permissions) required:** Site administration (that is, member of the *site-admin* [group](https://confluence.atlassian.com/x/24xjL)).
  """
  @spec create_group(Jirex.AddGroupBean.t(), keyword) :: {:ok, Jirex.Group.t()} | :error
  def create_group(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jirex.Groups, :create_group},
      url: "/rest/api/2/group",
      body: body,
      method: :post,
      request: [{"application/json", {Jirex.AddGroupBean, :t}}],
      response: [{201, {Jirex.Group, :t}}, {400, :null}, {401, :null}, {403, :null}],
      opts: opts
    })
  end

  @doc """
  Find groups

  Returns a list of groups whose names contain a query string. A list of group names can be provided to exclude groups from the results.

  The primary use case for this resource is to populate a group picker suggestions list. To this end, the returned object includes the `html` field where the matched query term is highlighted in the group name with the HTML strong tag. Also, the groups list is wrapped in a response object that contains a header for use in the picker, specifically *Showing X of Y matching groups*.

  The list returns with the groups sorted. If no groups match the list criteria, an empty list is returned.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg). Anonymous calls and calls by users without the required permission return an empty list.

  *Browse users and groups* [global permission](https://confluence.atlassian.com/x/x4dKLg). Without this permission, calls where query is not an exact match to an existing group will return an empty list.

  ## Options

    * `accountId`: This parameter is deprecated, setting it does not affect the results. To find groups containing a particular user, use [Get user groups](#api-rest-api-2-user-groups-get).
    * `query`: The string to find in group names.
    * `exclude`: As a group's name can change, use of `excludeGroupIds` is recommended to identify a group.
      A group to exclude from the result. To exclude multiple groups, provide an ampersand-separated list. For example, `exclude=group1&exclude=group2`. This parameter cannot be used with the `excludeGroupIds` parameter.
    * `excludeId`: A group ID to exclude from the result. To exclude multiple groups, provide an ampersand-separated list. For example, `excludeId=group1-id&excludeId=group2-id`. This parameter cannot be used with the `excludeGroups` parameter.
    * `maxResults`: The maximum number of groups to return. The maximum number of groups that can be returned is limited by the system property `jira.ajax.autocomplete.limit`.
    * `caseInsensitive`: Whether the search for groups should be case insensitive.
    * `userName`: This parameter is no longer available. See the [deprecation notice](https://developer.atlassian.com/cloud/jira/platform/deprecation-notice-user-privacy-api-migration-guide/) for details.

  """
  @spec find_groups(keyword) :: {:ok, Jirex.FoundGroups.t()} | :error
  def find_groups(opts \\ []) do
    client = opts[:client] || @default_client

    query =
      Keyword.take(opts, [
        :accountId,
        :caseInsensitive,
        :exclude,
        :excludeId,
        :maxResults,
        :query,
        :userName
      ])

    client.request(%{
      args: [],
      call: {Jirex.Groups, :find_groups},
      url: "/rest/api/2/groups/picker",
      method: :get,
      query: query,
      response: [{200, {Jirex.FoundGroups, :t}}],
      opts: opts
    })
  end

  @doc """
  Get group

  This operation is deprecated, use [`group/member`](#api-rest-api-2-group-member-get).

  Returns all users in a group.

  **[Permissions](#permissions) required:** either of:

   *  *Browse users and groups* [global permission](https://confluence.atlassian.com/x/x4dKLg).
   *  *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `groupname`: As a group's name can change, use of `groupId` is recommended to identify a group.
      The name of the group. This parameter cannot be used with the `groupId` parameter.
    * `groupId`: The ID of the group. This parameter cannot be used with the `groupName` parameter.
    * `expand`: List of fields to expand.

  """
  @spec get_group(keyword) :: {:ok, Jirex.Group.t()} | :error
  def get_group(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:expand, :groupId, :groupname])

    client.request(%{
      args: [],
      call: {Jirex.Groups, :get_group},
      url: "/rest/api/2/group",
      method: :get,
      query: query,
      response: [{200, {Jirex.Group, :t}}, {400, :null}, {401, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get users from group

  Returns a [paginated](#pagination) list of all users in a group.

  Note that users are ordered by username, however the username is not returned in the results due to privacy reasons.

  **[Permissions](#permissions) required:** either of:

   *  *Browse users and groups* [global permission](https://confluence.atlassian.com/x/x4dKLg).
   *  *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `groupname`: As a group's name can change, use of `groupId` is recommended to identify a group.
      The name of the group. This parameter cannot be used with the `groupId` parameter.
    * `groupId`: The ID of the group. This parameter cannot be used with the `groupName` parameter.
    * `includeInactiveUsers`: Include inactive users.
    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.

  """
  @spec get_users_from_group(keyword) :: {:ok, Jirex.PageBeanUserDetails.t()} | :error
  def get_users_from_group(opts \\ []) do
    client = opts[:client] || @default_client

    query =
      Keyword.take(opts, [:groupId, :groupname, :includeInactiveUsers, :maxResults, :startAt])

    client.request(%{
      args: [],
      call: {Jirex.Groups, :get_users_from_group},
      url: "/rest/api/2/group/member",
      method: :get,
      query: query,
      response: [
        {200, {Jirex.PageBeanUserDetails, :t}},
        {400, :null},
        {401, :null},
        {403, :null},
        {404, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Remove group

  Deletes a group.

  **[Permissions](#permissions) required:** Site administration (that is, member of the *site-admin* strategic [group](https://confluence.atlassian.com/x/24xjL)).

  ## Options

    * `groupname`
    * `groupId`: The ID of the group. This parameter cannot be used with the `groupname` parameter.
    * `swapGroup`: As a group's name can change, use of `swapGroupId` is recommended to identify a group.
      The group to transfer restrictions to. Only comments and worklogs are transferred. If restrictions are not transferred, comments and worklogs are inaccessible after the deletion. This parameter cannot be used with the `swapGroupId` parameter.
    * `swapGroupId`: The ID of the group to transfer restrictions to. Only comments and worklogs are transferred. If restrictions are not transferred, comments and worklogs are inaccessible after the deletion. This parameter cannot be used with the `swapGroup` parameter.

  """
  @spec remove_group(keyword) :: :ok | :error
  def remove_group(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:groupId, :groupname, :swapGroup, :swapGroupId])

    client.request(%{
      args: [],
      call: {Jirex.Groups, :remove_group},
      url: "/rest/api/2/group",
      method: :delete,
      query: query,
      response: [{200, :null}, {400, :null}, {401, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Remove user from group

  Removes a user from a group.

  **[Permissions](#permissions) required:** Site administration (that is, member of the *site-admin* [group](https://confluence.atlassian.com/x/24xjL)).

  ## Options

    * `groupname`: As a group's name can change, use of `groupId` is recommended to identify a group.
      The name of the group. This parameter cannot be used with the `groupId` parameter.
    * `groupId`: The ID of the group. This parameter cannot be used with the `groupName` parameter.
    * `username`: This parameter is no longer available. See the [deprecation notice](https://developer.atlassian.com/cloud/jira/platform/deprecation-notice-user-privacy-api-migration-guide/) for details.
    * `accountId`: The account ID of the user, which uniquely identifies the user across all Atlassian products. For example, *5b10ac8d82e05b22cc7d4ef5*.

  """
  @spec remove_user_from_group(keyword) :: :ok | :error
  def remove_user_from_group(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:accountId, :groupId, :groupname, :username])

    client.request(%{
      args: [],
      call: {Jirex.Groups, :remove_user_from_group},
      url: "/rest/api/2/group/user",
      method: :delete,
      query: query,
      response: [{200, :null}, {400, :null}, {401, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end
end
