defmodule Jirex.UserSearch do
  @moduledoc """
  Provides API endpoints related to user search
  """

  @default_client Jirex.Client

  @doc """
  Find users assignable to issues

  Returns a list of users that can be assigned to an issue. Use this operation to find the list of users who can be assigned to:

   *  a new issue, by providing the `projectKeyOrId`.
   *  an updated issue, by providing the `issueKey`.
   *  to an issue during a transition (workflow action), by providing the `issueKey` and the transition id in `actionDescriptorId`. You can obtain the IDs of an issue's valid transitions using the `transitions` option in the `expand` parameter of [ Get issue](#api-rest-api-2-issue-issueIdOrKey-get).

  In all these cases, you can pass an account ID to determine if a user can be assigned to an issue. The user is returned in the response if they can be assigned to the issue or issue transition.

  This operation takes the users in the range defined by `startAt` and `maxResults`, up to the thousandth user, and then returns only the users from that range that can be assigned the issue. This means the operation usually returns fewer users than specified in `maxResults`. To get all the users who can be assigned the issue, use [Get all users](#api-rest-api-2-users-search-get) and filter the records in your code.

  Privacy controls are applied to the response based on the users' preferences. This could mean, for example, that the user's email address is hidden. See the [Profile visibility overview](https://developer.atlassian.com/cloud/jira/platform/profile-visibility/) for more details.

  **[Permissions](#permissions) required:** *Browse users and groups* [global permission](https://confluence.atlassian.com/x/x4dKLg) or *Assign issues* [project permission](https://confluence.atlassian.com/x/yodKLg)

  ## Options

    * `query`: A query string that is matched against user attributes, such as `displayName`, and `emailAddress`, to find relevant users. The string can match the prefix of the attribute's value. For example, *query=john* matches a user with a `displayName` of *John Smith* and a user with an `emailAddress` of *johnson@example.com*. Required, unless `username` or `accountId` is specified.
    * `sessionId`: The sessionId of this request. SessionId is the same until the assignee is set.
    * `username`: This parameter is no longer available. See the [deprecation notice](https://developer.atlassian.com/cloud/jira/platform/deprecation-notice-user-privacy-api-migration-guide/) for details.
    * `accountId`: A query string that is matched exactly against user `accountId`. Required, unless `query` is specified.
    * `project`: The project ID or project key (case sensitive). Required, unless `issueKey` is specified.
    * `issueKey`: The key of the issue. Required, unless `project` is specified.
    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return. This operation may return less than the maximum number of items even if more are available. The operation fetches users up to the maximum and then, from the fetched users, returns only the users that can be assigned to the issue.
    * `actionDescriptorId`: The ID of the transition.
    * `recommend`

  """
  @spec find_assignable_users(keyword) :: {:ok, [Jirex.User.t()]} | :error
  def find_assignable_users(opts \\ []) do
    client = opts[:client] || @default_client

    query =
      Keyword.take(opts, [
        :accountId,
        :actionDescriptorId,
        :issueKey,
        :maxResults,
        :project,
        :query,
        :recommend,
        :sessionId,
        :startAt,
        :username
      ])

    client.request(%{
      args: [],
      call: {Jirex.UserSearch, :find_assignable_users},
      url: "/rest/api/2/user/assignable/search",
      method: :get,
      query: query,
      response: [
        {200, [{Jirex.User, :t}]},
        {400, :null},
        {401, :null},
        {404, :null},
        {429, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Find users assignable to projects

  Returns a list of users who can be assigned issues in one or more projects. The list may be restricted to users whose attributes match a string.

  This operation takes the users in the range defined by `startAt` and `maxResults`, up to the thousandth user, and then returns only the users from that range that can be assigned issues in the projects. This means the operation usually returns fewer users than specified in `maxResults`. To get all the users who can be assigned issues in the projects, use [Get all users](#api-rest-api-2-users-search-get) and filter the records in your code.

  Privacy controls are applied to the response based on the users' preferences. This could mean, for example, that the user's email address is hidden. See the [Profile visibility overview](https://developer.atlassian.com/cloud/jira/platform/profile-visibility/) for more details.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** None.

  ## Options

    * `query`: A query string that is matched against user attributes, such as `displayName` and `emailAddress`, to find relevant users. The string can match the prefix of the attribute's value. For example, *query=john* matches a user with a `displayName` of *John Smith* and a user with an `emailAddress` of *johnson@example.com*. Required, unless `accountId` is specified.
    * `username`: This parameter is no longer available. See the [deprecation notice](https://developer.atlassian.com/cloud/jira/platform/deprecation-notice-user-privacy-api-migration-guide/) for details.
    * `accountId`: A query string that is matched exactly against user `accountId`. Required, unless `query` is specified.
    * `projectKeys`: A list of project keys (case sensitive). This parameter accepts a comma-separated list.
    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.

  """
  @spec find_bulk_assignable_users(keyword) :: {:ok, [Jirex.User.t()]} | :error
  def find_bulk_assignable_users(opts \\ []) do
    client = opts[:client] || @default_client

    query =
      Keyword.take(opts, [:accountId, :maxResults, :projectKeys, :query, :startAt, :username])

    client.request(%{
      args: [],
      call: {Jirex.UserSearch, :find_bulk_assignable_users},
      url: "/rest/api/2/user/assignable/multiProjectSearch",
      method: :get,
      query: query,
      response: [
        {200, [{Jirex.User, :t}]},
        {400, :null},
        {401, :null},
        {404, :null},
        {429, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Find user keys by query

  Finds users with a structured query and returns a [paginated](#pagination) list of user keys.

  This operation takes the users in the range defined by `startAt` and `maxResults`, up to the thousandth user, and then returns only the users from that range that match the structured query. This means the operation usually returns fewer users than specified in `maxResults`. To get all the users who match the structured query, use [Get all users](#api-rest-api-2-users-search-get) and filter the records in your code.

  **[Permissions](#permissions) required:** *Browse users and groups* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  The query statements are:

   *  `is assignee of PROJ` Returns the users that are assignees of at least one issue in project *PROJ*.
   *  `is assignee of (PROJ-1, PROJ-2)` Returns users that are assignees on the issues *PROJ-1* or *PROJ-2*.
   *  `is reporter of (PROJ-1, PROJ-2)` Returns users that are reporters on the issues *PROJ-1* or *PROJ-2*.
   *  `is watcher of (PROJ-1, PROJ-2)` Returns users that are watchers on the issues *PROJ-1* or *PROJ-2*.
   *  `is voter of (PROJ-1, PROJ-2)` Returns users that are voters on the issues *PROJ-1* or *PROJ-2*.
   *  `is commenter of (PROJ-1, PROJ-2)` Returns users that have posted a comment on the issues *PROJ-1* or *PROJ-2*.
   *  `is transitioner of (PROJ-1, PROJ-2)` Returns users that have performed a transition on issues *PROJ-1* or *PROJ-2*.
   *  `[propertyKey].entity.property.path is "property value"` Returns users with the entity property value.

  The list of issues can be extended as needed, as in *(PROJ-1, PROJ-2, ... PROJ-n)*. Statements can be combined using the `AND` and `OR` operators to form more complex queries. For example:

  `is assignee of PROJ AND [propertyKey].entity.property.path is "property value"`

  ## Options

    * `query`: The search query.
    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResult`: The maximum number of items to return per page.

  """
  @spec find_user_keys_by_query(keyword) ::
          {:ok, Jirex.PageBeanUserKey.t()} | {:error, Jirex.ErrorCollection.t()}
  def find_user_keys_by_query(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:maxResult, :query, :startAt])

    client.request(%{
      args: [],
      call: {Jirex.UserSearch, :find_user_keys_by_query},
      url: "/rest/api/2/user/search/query/key",
      method: :get,
      query: query,
      response: [
        {200, {Jirex.PageBeanUserKey, :t}},
        {400, {Jirex.ErrorCollection, :t}},
        {401, {Jirex.ErrorCollection, :t}},
        {403, {Jirex.ErrorCollection, :t}},
        {408, {Jirex.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Find users

  Returns a list of active users that match the search string and property.

  This operation first applies a filter to match the search string and property, and then takes the filtered users in the range defined by `startAt` and `maxResults`, up to the thousandth user. To get all the users who match the search string and property, use [Get all users](#api-rest-api-2-users-search-get) and filter the records in your code.

  This operation can be accessed anonymously.

  Privacy controls are applied to the response based on the users' preferences. This could mean, for example, that the user's email address is hidden. See the [Profile visibility overview](https://developer.atlassian.com/cloud/jira/platform/profile-visibility/) for more details.

  **[Permissions](#permissions) required:** *Browse users and groups* [global permission](https://confluence.atlassian.com/x/x4dKLg). Anonymous calls or calls by users without the required permission return empty search results.

  ## Options

    * `query`: A query string that is matched against user attributes ( `displayName`, and `emailAddress`) to find relevant users. The string can match the prefix of the attribute's value. For example, *query=john* matches a user with a `displayName` of *John Smith* and a user with an `emailAddress` of *johnson@example.com*. Required, unless `accountId` or `property` is specified.
    * `username`
    * `accountId`: A query string that is matched exactly against a user `accountId`. Required, unless `query` or `property` is specified.
    * `startAt`: The index of the first item to return in a page of filtered results (page offset).
    * `maxResults`: The maximum number of items to return per page.
    * `property`: A query string used to search properties. Property keys are specified by path, so property keys containing dot (.) or equals (=) characters cannot be used. The query string cannot be specified using a JSON object. Example: To search for the value of `nested` from `{"something":{"nested":1,"other":2}}` use `thepropertykey.something.nested=1`. Required, unless `accountId` or `query` is specified.

  """
  @spec find_users(keyword) :: {:ok, [Jirex.User.t()]} | :error
  def find_users(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:accountId, :maxResults, :property, :query, :startAt, :username])

    client.request(%{
      args: [],
      call: {Jirex.UserSearch, :find_users},
      url: "/rest/api/2/user/search",
      method: :get,
      query: query,
      response: [{200, [{Jirex.User, :t}]}, {400, :null}, {401, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Find users by query

  Finds users with a structured query and returns a [paginated](#pagination) list of user details.

  This operation takes the users in the range defined by `startAt` and `maxResults`, up to the thousandth user, and then returns only the users from that range that match the structured query. This means the operation usually returns fewer users than specified in `maxResults`. To get all the users who match the structured query, use [Get all users](#api-rest-api-2-users-search-get) and filter the records in your code.

  **[Permissions](#permissions) required:** *Browse users and groups* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  The query statements are:

   *  `is assignee of PROJ` Returns the users that are assignees of at least one issue in project *PROJ*.
   *  `is assignee of (PROJ-1, PROJ-2)` Returns users that are assignees on the issues *PROJ-1* or *PROJ-2*.
   *  `is reporter of (PROJ-1, PROJ-2)` Returns users that are reporters on the issues *PROJ-1* or *PROJ-2*.
   *  `is watcher of (PROJ-1, PROJ-2)` Returns users that are watchers on the issues *PROJ-1* or *PROJ-2*.
   *  `is voter of (PROJ-1, PROJ-2)` Returns users that are voters on the issues *PROJ-1* or *PROJ-2*.
   *  `is commenter of (PROJ-1, PROJ-2)` Returns users that have posted a comment on the issues *PROJ-1* or *PROJ-2*.
   *  `is transitioner of (PROJ-1, PROJ-2)` Returns users that have performed a transition on issues *PROJ-1* or *PROJ-2*.
   *  `[propertyKey].entity.property.path is "property value"` Returns users with the entity property value.

  The list of issues can be extended as needed, as in *(PROJ-1, PROJ-2, ... PROJ-n)*. Statements can be combined using the `AND` and `OR` operators to form more complex queries. For example:

  `is assignee of PROJ AND [propertyKey].entity.property.path is "property value"`

  ## Options

    * `query`: The search query.
    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.

  """
  @spec find_users_by_query(keyword) ::
          {:ok, Jirex.PageBeanUser.t()} | {:error, Jirex.ErrorCollection.t()}
  def find_users_by_query(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:maxResults, :query, :startAt])

    client.request(%{
      args: [],
      call: {Jirex.UserSearch, :find_users_by_query},
      url: "/rest/api/2/user/search/query",
      method: :get,
      query: query,
      response: [
        {200, {Jirex.PageBeanUser, :t}},
        {400, {Jirex.ErrorCollection, :t}},
        {401, {Jirex.ErrorCollection, :t}},
        {403, {Jirex.ErrorCollection, :t}},
        {408, {Jirex.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Find users for picker

  Returns a list of users whose attributes match the query term. The returned object includes the `html` field where the matched query term is highlighted with the HTML strong tag. A list of account IDs can be provided to exclude users from the results.

  This operation takes the users in the range defined by `maxResults`, up to the thousandth user, and then returns only the users from that range that match the query term. This means the operation usually returns fewer users than specified in `maxResults`. To get all the users who match the query term, use [Get all users](#api-rest-api-2-users-search-get) and filter the records in your code.

  Privacy controls are applied to the response based on the users' preferences. This could mean, for example, that the user's email address is hidden. See the [Profile visibility overview](https://developer.atlassian.com/cloud/jira/platform/profile-visibility/) for more details.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** *Browse users and groups* [global permission](https://confluence.atlassian.com/x/x4dKLg). Anonymous calls and calls by users without the required permission return search results for an exact name match only.

  ## Options

    * `query`: A query string that is matched against user attributes, such as `displayName`, and `emailAddress`, to find relevant users. The string can match the prefix of the attribute's value. For example, *query=john* matches a user with a `displayName` of *John Smith* and a user with an `emailAddress` of *johnson@example.com*.
    * `maxResults`: The maximum number of items to return. The total number of matched users is returned in `total`.
    * `showAvatar`: Include the URI to the user's avatar.
    * `exclude`: This parameter is no longer available. See the [deprecation notice](https://developer.atlassian.com/cloud/jira/platform/deprecation-notice-user-privacy-api-migration-guide/) for details.
    * `excludeAccountIds`: A list of account IDs to exclude from the search results. This parameter accepts a comma-separated list. Multiple account IDs can also be provided using an ampersand-separated list. For example, `excludeAccountIds=5b10a2844c20165700ede21g,5b10a0effa615349cb016cd8&excludeAccountIds=5b10ac8d82e05b22cc7d4ef5`. Cannot be provided with `exclude`.
    * `avatarSize`
    * `excludeConnectUsers`

  """
  @spec find_users_for_picker(keyword) :: {:ok, Jirex.FoundUsers.t()} | :error
  def find_users_for_picker(opts \\ []) do
    client = opts[:client] || @default_client

    query =
      Keyword.take(opts, [
        :avatarSize,
        :exclude,
        :excludeAccountIds,
        :excludeConnectUsers,
        :maxResults,
        :query,
        :showAvatar
      ])

    client.request(%{
      args: [],
      call: {Jirex.UserSearch, :find_users_for_picker},
      url: "/rest/api/2/user/picker",
      method: :get,
      query: query,
      response: [{200, {Jirex.FoundUsers, :t}}, {400, :null}, {401, :null}, {429, :null}],
      opts: opts
    })
  end

  @doc """
  Find users with permissions

  Returns a list of users who fulfill these criteria:

   *  their user attributes match a search string.
   *  they have a set of permissions for a project or issue.

  If no search string is provided, a list of all users with the permissions is returned.

  This operation takes the users in the range defined by `startAt` and `maxResults`, up to the thousandth user, and then returns only the users from that range that match the search string and have permission for the project or issue. This means the operation usually returns fewer users than specified in `maxResults`. To get all the users who match the search string and have permission for the project or issue, use [Get all users](#api-rest-api-2-users-search-get) and filter the records in your code.

  Privacy controls are applied to the response based on the users' preferences. This could mean, for example, that the user's email address is hidden. See the [Profile visibility overview](https://developer.atlassian.com/cloud/jira/platform/profile-visibility/) for more details.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:**

   *  *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg), to get users for any project.
   *  *Administer Projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for a project, to get users for that project.

  ## Options

    * `query`: A query string that is matched against user attributes, such as `displayName` and `emailAddress`, to find relevant users. The string can match the prefix of the attribute's value. For example, *query=john* matches a user with a `displayName` of *John Smith* and a user with an `emailAddress` of *johnson@example.com*. Required, unless `accountId` is specified.
    * `username`: This parameter is no longer available. See the [deprecation notice](https://developer.atlassian.com/cloud/jira/platform/deprecation-notice-user-privacy-api-migration-guide/) for details.
    * `accountId`: A query string that is matched exactly against user `accountId`. Required, unless `query` is specified.
    * `permissions`: A comma separated list of permissions. Permissions can be specified as any:

       *  permission returned by [Get all permissions](#api-rest-api-2-permissions-get).
       *  custom project permission added by Connect apps.
       *  (deprecated) one of the following:

           *  ASSIGNABLE\_USER
           *  ASSIGN\_ISSUE
           *  ATTACHMENT\_DELETE\_ALL
           *  ATTACHMENT\_DELETE\_OWN
           *  BROWSE
           *  CLOSE\_ISSUE
           *  COMMENT\_DELETE\_ALL
           *  COMMENT\_DELETE\_OWN
           *  COMMENT\_EDIT\_ALL
           *  COMMENT\_EDIT\_OWN
           *  COMMENT\_ISSUE
           *  CREATE\_ATTACHMENT
           *  CREATE\_ISSUE
           *  DELETE\_ISSUE
           *  EDIT\_ISSUE
           *  LINK\_ISSUE
           *  MANAGE\_WATCHER\_LIST
           *  MODIFY\_REPORTER
           *  MOVE\_ISSUE
           *  PROJECT\_ADMIN
           *  RESOLVE\_ISSUE
           *  SCHEDULE\_ISSUE
           *  SET\_ISSUE\_SECURITY
           *  TRANSITION\_ISSUE
           *  VIEW\_VERSION\_CONTROL
           *  VIEW\_VOTERS\_AND\_WATCHERS
           *  VIEW\_WORKFLOW\_READONLY
           *  WORKLOG\_DELETE\_ALL
           *  WORKLOG\_DELETE\_OWN
           *  WORKLOG\_EDIT\_ALL
           *  WORKLOG\_EDIT\_OWN
           *  WORK\_ISSUE
    * `issueKey`: The issue key for the issue.
    * `projectKey`: The project key for the project (case sensitive).
    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.

  """
  @spec find_users_with_all_permissions(keyword) :: {:ok, [Jirex.User.t()]} | :error
  def find_users_with_all_permissions(opts \\ []) do
    client = opts[:client] || @default_client

    query =
      Keyword.take(opts, [
        :accountId,
        :issueKey,
        :maxResults,
        :permissions,
        :projectKey,
        :query,
        :startAt,
        :username
      ])

    client.request(%{
      args: [],
      call: {Jirex.UserSearch, :find_users_with_all_permissions},
      url: "/rest/api/2/user/permission/search",
      method: :get,
      query: query,
      response: [
        {200, [{Jirex.User, :t}]},
        {400, :null},
        {401, :null},
        {403, :null},
        {404, :null},
        {429, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Find users with browse permission

  Returns a list of users who fulfill these criteria:

   *  their user attributes match a search string.
   *  they have permission to browse issues.

  Use this resource to find users who can browse:

   *  an issue, by providing the `issueKey`.
   *  any issue in a project, by providing the `projectKey`.

  This operation takes the users in the range defined by `startAt` and `maxResults`, up to the thousandth user, and then returns only the users from that range that match the search string and have permission to browse issues. This means the operation usually returns fewer users than specified in `maxResults`. To get all the users who match the search string and have permission to browse issues, use [Get all users](#api-rest-api-2-users-search-get) and filter the records in your code.

  Privacy controls are applied to the response based on the users' preferences. This could mean, for example, that the user's email address is hidden. See the [Profile visibility overview](https://developer.atlassian.com/cloud/jira/platform/profile-visibility/) for more details.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** *Browse users and groups* [global permission](https://confluence.atlassian.com/x/x4dKLg). Anonymous calls and calls by users without the required permission return empty search results.

  ## Options

    * `query`: A query string that is matched against user attributes, such as `displayName` and `emailAddress`, to find relevant users. The string can match the prefix of the attribute's value. For example, *query=john* matches a user with a `displayName` of *John Smith* and a user with an `emailAddress` of *johnson@example.com*. Required, unless `accountId` is specified.
    * `username`: This parameter is no longer available. See the [deprecation notice](https://developer.atlassian.com/cloud/jira/platform/deprecation-notice-user-privacy-api-migration-guide/) for details.
    * `accountId`: A query string that is matched exactly against user `accountId`. Required, unless `query` is specified.
    * `issueKey`: The issue key for the issue. Required, unless `projectKey` is specified.
    * `projectKey`: The project key for the project (case sensitive). Required, unless `issueKey` is specified.
    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.

  """
  @spec find_users_with_browse_permission(keyword) :: {:ok, [Jirex.User.t()]} | :error
  def find_users_with_browse_permission(opts \\ []) do
    client = opts[:client] || @default_client

    query =
      Keyword.take(opts, [
        :accountId,
        :issueKey,
        :maxResults,
        :projectKey,
        :query,
        :startAt,
        :username
      ])

    client.request(%{
      args: [],
      call: {Jirex.UserSearch, :find_users_with_browse_permission},
      url: "/rest/api/2/user/viewissue/search",
      method: :get,
      query: query,
      response: [
        {200, [{Jirex.User, :t}]},
        {400, :null},
        {401, :null},
        {404, :null},
        {429, :null}
      ],
      opts: opts
    })
  end
end
