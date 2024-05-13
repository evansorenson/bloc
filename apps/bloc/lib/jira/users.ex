defmodule Jira.Users do
  @moduledoc """
  Provides API endpoints related to users
  """

  @default_client Jira.Client

  @doc """
  Bulk get users

  Returns a [paginated](#pagination) list of the users specified by one or more account IDs.

  **[Permissions](#permissions) required:** Permission to access Jira.

  ## Options

    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.
    * `username`: This parameter is no longer available and will be removed from the documentation soon. See the [deprecation notice](https://developer.atlassian.com/cloud/jira/platform/deprecation-notice-user-privacy-api-migration-guide/) for details.
    * `key`: This parameter is no longer available and will be removed from the documentation soon. See the [deprecation notice](https://developer.atlassian.com/cloud/jira/platform/deprecation-notice-user-privacy-api-migration-guide/) for details.
    * `accountId`: The account ID of a user. To specify multiple users, pass multiple `accountId` parameters. For example, `accountId=5b10a2844c20165700ede21g&accountId=5b10ac8d82e05b22cc7d4ef5`.

  """
  @spec bulk_get_users(keyword) :: {:ok, Jira.PageBeanUser.t()} | :error
  def bulk_get_users(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:accountId, :key, :maxResults, :startAt, :username])

    client.request(%{
      args: [],
      call: {Jira.Users, :bulk_get_users},
      url: "/rest/api/2/user/bulk",
      method: :get,
      query: query,
      response: [{200, {Jira.PageBeanUser, :t}}, {400, :null}, {401, :null}],
      opts: opts
    })
  end

  @doc """
  Get account IDs for users

  Returns the account IDs for the users specified in the `key` or `username` parameters. Note that multiple `key` or `username` parameters can be specified.

  **[Permissions](#permissions) required:** Permission to access Jira.

  ## Options

    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.
    * `username`: Username of a user. To specify multiple users, pass multiple copies of this parameter. For example, `username=fred&username=barney`. Required if `key` isn't provided. Cannot be provided if `key` is present.
    * `key`: Key of a user. To specify multiple users, pass multiple copies of this parameter. For example, `key=fred&key=barney`. Required if `username` isn't provided. Cannot be provided if `username` is present.

  """
  @spec bulk_get_users_migration(keyword) :: {:ok, [Jira.UserMigrationBean.t()]} | :error
  def bulk_get_users_migration(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:key, :maxResults, :startAt, :username])

    client.request(%{
      args: [],
      call: {Jira.Users, :bulk_get_users_migration},
      url: "/rest/api/2/user/bulk/migration",
      method: :get,
      query: query,
      response: [{200, [{Jira.UserMigrationBean, :t}]}, {400, :null}, {401, :null}],
      opts: opts
    })
  end

  @doc """
  Create user

  Creates a user. This resource is retained for legacy compatibility. As soon as a more suitable alternative is available this resource will be deprecated.

  If the user exists and has access to Jira, the operation returns a 201 status. If the user exists but does not have access to Jira, the operation returns a 400 status.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec create_user(Jira.NewUserDetails.t(), keyword) :: {:ok, Jira.User.t()} | :error
  def create_user(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jira.Users, :create_user},
      url: "/rest/api/2/user",
      body: body,
      method: :post,
      request: [{"application/json", {Jira.NewUserDetails, :t}}],
      response: [{201, {Jira.User, :t}}, {400, :null}, {401, :null}, {403, :null}],
      opts: opts
    })
  end

  @doc """
  Get all users

  Returns a list of all users, including active users, inactive users and previously deleted users that have an Atlassian account.

  Privacy controls are applied to the response based on the users' preferences. This could mean, for example, that the user's email address is hidden. See the [Profile visibility overview](https://developer.atlassian.com/cloud/jira/platform/profile-visibility/) for more details.

  **[Permissions](#permissions) required:** *Browse users and groups* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `startAt`: The index of the first item to return.
    * `maxResults`: The maximum number of items to return.

  """
  @spec get_all_users(keyword) :: {:ok, [Jira.User.t()]} | :error
  def get_all_users(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:maxResults, :startAt])

    client.request(%{
      args: [],
      call: {Jira.Users, :get_all_users},
      url: "/rest/api/2/users/search",
      method: :get,
      query: query,
      response: [{200, [{Jira.User, :t}]}, {400, :null}, {403, :null}, {409, :null}],
      opts: opts
    })
  end

  @doc """
  Get all users default

  Returns a list of all users, including active users, inactive users and previously deleted users that have an Atlassian account.

  Privacy controls are applied to the response based on the users' preferences. This could mean, for example, that the user's email address is hidden. See the [Profile visibility overview](https://developer.atlassian.com/cloud/jira/platform/profile-visibility/) for more details.

  **[Permissions](#permissions) required:** *Browse users and groups* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `startAt`: The index of the first item to return.
    * `maxResults`: The maximum number of items to return.

  """
  @spec get_all_users_default(keyword) :: {:ok, [Jira.User.t()]} | :error
  def get_all_users_default(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:maxResults, :startAt])

    client.request(%{
      args: [],
      call: {Jira.Users, :get_all_users_default},
      url: "/rest/api/2/users",
      method: :get,
      query: query,
      response: [{200, [{Jira.User, :t}]}, {400, :null}, {403, :null}, {409, :null}],
      opts: opts
    })
  end

  @doc """
  Get user

  Returns a user.

  Privacy controls are applied to the response based on the user's preferences. This could mean, for example, that the user's email address is hidden. See the [Profile visibility overview](https://developer.atlassian.com/cloud/jira/platform/profile-visibility/) for more details.

  **[Permissions](#permissions) required:** *Browse users and groups* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `accountId`: The account ID of the user, which uniquely identifies the user across all Atlassian products. For example, *5b10ac8d82e05b22cc7d4ef5*. Required.
    * `username`: This parameter is no longer available. See the [deprecation notice](https://developer.atlassian.com/cloud/jira/platform/deprecation-notice-user-privacy-api-migration-guide) for details.
    * `key`: This parameter is no longer available. See the [deprecation notice](https://developer.atlassian.com/cloud/jira/platform/deprecation-notice-user-privacy-api-migration-guide) for details.
    * `expand`: Use [expand](#expansion) to include additional information about users in the response. This parameter accepts a comma-separated list. Expand options include:
      
       *  `groups` includes all groups and nested groups to which the user belongs.
       *  `applicationRoles` includes details of all the applications to which the user has access.

  """
  @spec get_user(keyword) :: {:ok, Jira.User.t()} | :error
  def get_user(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:accountId, :expand, :key, :username])

    client.request(%{
      args: [],
      call: {Jira.Users, :get_user},
      url: "/rest/api/2/user",
      method: :get,
      query: query,
      response: [{200, {Jira.User, :t}}, {401, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get user default columns

  Returns the default [issue table columns](https://confluence.atlassian.com/x/XYdKLg) for the user. If `accountId` is not passed in the request, the calling user's details are returned.

  **[Permissions](#permissions) required:**

   *  *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLgl), to get the column details for any user.
   *  Permission to access Jira, to get the calling user's column details.

  ## Options

    * `accountId`: The account ID of the user, which uniquely identifies the user across all Atlassian products. For example, *5b10ac8d82e05b22cc7d4ef5*.
    * `username`: This parameter is no longer available See the [deprecation notice](https://developer.atlassian.com/cloud/jira/platform/deprecation-notice-user-privacy-api-migration-guide/) for details.

  """
  @spec get_user_default_columns(keyword) :: {:ok, [Jira.ColumnItem.t()]} | :error
  def get_user_default_columns(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:accountId, :username])

    client.request(%{
      args: [],
      call: {Jira.Users, :get_user_default_columns},
      url: "/rest/api/2/user/columns",
      method: :get,
      query: query,
      response: [{200, [{Jira.ColumnItem, :t}]}, {401, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get user email

  Returns a user's email address. This API is only available to apps approved by Atlassian, according to these [guidelines](https://community.developer.atlassian.com/t/guidelines-for-requesting-access-to-email-address/27603).

  ## Options

    * `accountId`: The account ID of the user, which uniquely identifies the user across all Atlassian products. For example, `5b10ac8d82e05b22cc7d4ef5`.

  """
  @spec get_user_email(keyword) :: {:ok, Jira.UnrestrictedUserEmail.t()} | :error
  def get_user_email(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:accountId])

    client.request(%{
      args: [],
      call: {Jira.Users, :get_user_email},
      url: "/rest/api/2/user/email",
      method: :get,
      query: query,
      response: [
        {200, {Jira.UnrestrictedUserEmail, :t}},
        {400, :null},
        {401, :null},
        {404, :null},
        {503, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Get user email bulk

  Returns a user's email address. This API is only available to apps approved by Atlassian, according to these [guidelines](https://community.developer.atlassian.com/t/guidelines-for-requesting-access-to-email-address/27603).

  ## Options

    * `accountId`: The account IDs of the users for which emails are required. An `accountId` is an identifier that uniquely identifies the user across all Atlassian products. For example, `5b10ac8d82e05b22cc7d4ef5`. Note, this should be treated as an opaque identifier (that is, do not assume any structure in the value).

  """
  @spec get_user_email_bulk(keyword) :: {:ok, Jira.UnrestrictedUserEmail.t()} | :error
  def get_user_email_bulk(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:accountId])

    client.request(%{
      args: [],
      call: {Jira.Users, :get_user_email_bulk},
      url: "/rest/api/2/user/email/bulk",
      method: :get,
      query: query,
      response: [
        {200, {Jira.UnrestrictedUserEmail, :t}},
        {400, :null},
        {401, :null},
        {503, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Get user groups

  Returns the groups to which a user belongs.

  **[Permissions](#permissions) required:** *Browse users and groups* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `accountId`: The account ID of the user, which uniquely identifies the user across all Atlassian products. For example, *5b10ac8d82e05b22cc7d4ef5*.
    * `username`: This parameter is no longer available. See the [deprecation notice](https://developer.atlassian.com/cloud/jira/platform/deprecation-notice-user-privacy-api-migration-guide/) for details.
    * `key`: This parameter is no longer available. See the [deprecation notice](https://developer.atlassian.com/cloud/jira/platform/deprecation-notice-user-privacy-api-migration-guide/) for details.

  """
  @spec get_user_groups(keyword) :: {:ok, [Jira.GroupName.t()]} | :error
  def get_user_groups(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:accountId, :key, :username])

    client.request(%{
      args: [],
      call: {Jira.Users, :get_user_groups},
      url: "/rest/api/2/user/groups",
      method: :get,
      query: query,
      response: [{200, [{Jira.GroupName, :t}]}, {401, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Delete user

  Deletes a user. If the operation completes successfully then the user is removed from Jira's user base. This operation does not delete the user's Atlassian account.

  **[Permissions](#permissions) required:** Site administration (that is, membership of the *site-admin* [group](https://confluence.atlassian.com/x/24xjL)).

  ## Options

    * `accountId`: The account ID of the user, which uniquely identifies the user across all Atlassian products. For example, *5b10ac8d82e05b22cc7d4ef5*.
    * `username`: This parameter is no longer available. See the [deprecation notice](https://developer.atlassian.com/cloud/jira/platform/deprecation-notice-user-privacy-api-migration-guide/) for details.
    * `key`: This parameter is no longer available. See the [deprecation notice](https://developer.atlassian.com/cloud/jira/platform/deprecation-notice-user-privacy-api-migration-guide/) for details.

  """
  @spec remove_user(keyword) :: :ok | :error
  def remove_user(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:accountId, :key, :username])

    client.request(%{
      args: [],
      call: {Jira.Users, :remove_user},
      url: "/rest/api/2/user",
      method: :delete,
      query: query,
      response: [{204, :null}, {400, :null}, {401, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Reset user default columns

  Resets the default [ issue table columns](https://confluence.atlassian.com/x/XYdKLg) for the user to the system default. If `accountId` is not passed, the calling user's default columns are reset.

  **[Permissions](#permissions) required:**

   *  *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg), to set the columns on any user.
   *  Permission to access Jira, to set the calling user's columns.

  ## Options

    * `accountId`: The account ID of the user, which uniquely identifies the user across all Atlassian products. For example, *5b10ac8d82e05b22cc7d4ef5*.
    * `username`: This parameter is no longer available. See the [deprecation notice](https://developer.atlassian.com/cloud/jira/platform/deprecation-notice-user-privacy-api-migration-guide/) for details.

  """
  @spec reset_user_columns(keyword) :: :ok | :error
  def reset_user_columns(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:accountId, :username])

    client.request(%{
      args: [],
      call: {Jira.Users, :reset_user_columns},
      url: "/rest/api/2/user/columns",
      method: :delete,
      query: query,
      response: [{204, :null}, {401, :null}, {403, :null}],
      opts: opts
    })
  end

  @doc """
  Set user default columns

  Sets the default [ issue table columns](https://confluence.atlassian.com/x/XYdKLg) for the user. If an account ID is not passed, the calling user's default columns are set. If no column details are sent, then all default columns are removed.

  The parameters for this resource are expressed as HTML form data. For example, in curl:

  `curl -X PUT -d columns=summary -d columns=description https://your-domain.atlassian.net/rest/api/2/user/columns?accountId=5b10ac8d82e05b22cc7d4ef5'`

  **[Permissions](#permissions) required:**

   *  *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg), to set the columns on any user.
   *  Permission to access Jira, to set the calling user's columns.

  ## Options

    * `accountId`: The account ID of the user, which uniquely identifies the user across all Atlassian products. For example, *5b10ac8d82e05b22cc7d4ef5*.

  """
  @spec set_user_columns(Jira.UserColumnRequestBody.t(), keyword) :: {:ok, map} | :error
  def set_user_columns(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:accountId])

    client.request(%{
      args: [body: body],
      call: {Jira.Users, :set_user_columns},
      url: "/rest/api/2/user/columns",
      body: body,
      method: :put,
      query: query,
      request: [
        {"*/*", {Jira.UserColumnRequestBody, :t}},
        {"multipart/form-data", {Jira.UserColumnRequestBody, :t}}
      ],
      response: [
        {200, :map},
        {401, :null},
        {403, :null},
        {404, :null},
        {429, :null},
        {500, :null}
      ],
      opts: opts
    })
  end
end
