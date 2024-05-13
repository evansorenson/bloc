defmodule Jira.Filters do
  @moduledoc """
  Provides API endpoints related to filters
  """

  @default_client Jira.Client

  @doc """
  Change filter owner

  Changes the owner of the filter.

  **[Permissions](#permissions) required:** Permission to access Jira. However, the user must own the filter or have the *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec change_filter_owner(integer, Jira.ChangeFilterOwner.t(), keyword) :: {:ok, map} | :error
  def change_filter_owner(id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id, body: body],
      call: {Jira.Filters, :change_filter_owner},
      url: "/rest/api/2/filter/#{id}/owner",
      body: body,
      method: :put,
      request: [{"application/json", {Jira.ChangeFilterOwner, :t}}],
      response: [{204, :map}, {400, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Create filter

  Creates a filter. The filter is shared according to the [default share scope](#api-rest-api-2-filter-post). The filter is not selected as a favorite.

  **[Permissions](#permissions) required:** Permission to access Jira.

  ## Options

    * `expand`: Use [expand](#expansion) to include additional information about filter in the response. This parameter accepts a comma-separated list. Expand options include:
      
       *  `sharedUsers` Returns the users that the filter is shared with. This includes users that can browse projects that the filter is shared with. If you don't specify `sharedUsers`, then the `sharedUsers` object is returned but it doesn't list any users. The list of users returned is limited to 1000, to access additional users append `[start-index:end-index]` to the expand request. For example, to access the next 1000 users, use `?expand=sharedUsers[1001:2000]`.
       *  `subscriptions` Returns the users that are subscribed to the filter. If you don't specify `subscriptions`, the `subscriptions` object is returned but it doesn't list any subscriptions. The list of subscriptions returned is limited to 1000, to access additional subscriptions append `[start-index:end-index]` to the expand request. For example, to access the next 1000 subscriptions, use `?expand=subscriptions[1001:2000]`.
    * `overrideSharePermissions`: EXPERIMENTAL: Whether share permissions are overridden to enable filters with any share permissions to be created. Available to users with *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  """
  @spec create_filter(Jira.Filter.t(), keyword) :: {:ok, Jira.Filter.t()} | :error
  def create_filter(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:expand, :overrideSharePermissions])

    client.request(%{
      args: [body: body],
      call: {Jira.Filters, :create_filter},
      url: "/rest/api/2/filter",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Jira.Filter, :t}}],
      response: [{200, {Jira.Filter, :t}}, {400, :null}, {401, :null}],
      opts: opts
    })
  end

  @doc """
  Remove filter as favorite

  Removes a filter as a favorite for the user. Note that this operation only removes filters visible to the user from the user's favorites list. For example, if the user favorites a public filter that is subsequently made private (and is therefore no longer visible on their favorites list) they cannot remove it from their favorites list.

  **[Permissions](#permissions) required:** Permission to access Jira.

  ## Options

    * `expand`: Use [expand](#expansion) to include additional information about filter in the response. This parameter accepts a comma-separated list. Expand options include:
      
       *  `sharedUsers` Returns the users that the filter is shared with. This includes users that can browse projects that the filter is shared with. If you don't specify `sharedUsers`, then the `sharedUsers` object is returned but it doesn't list any users. The list of users returned is limited to 1000, to access additional users append `[start-index:end-index]` to the expand request. For example, to access the next 1000 users, use `?expand=sharedUsers[1001:2000]`.
       *  `subscriptions` Returns the users that are subscribed to the filter. If you don't specify `subscriptions`, the `subscriptions` object is returned but it doesn't list any subscriptions. The list of subscriptions returned is limited to 1000, to access additional subscriptions append `[start-index:end-index]` to the expand request. For example, to access the next 1000 subscriptions, use `?expand=subscriptions[1001:2000]`.

  """
  @spec delete_favourite_for_filter(integer, keyword) :: {:ok, Jira.Filter.t()} | :error
  def delete_favourite_for_filter(id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:expand])

    client.request(%{
      args: [id: id],
      call: {Jira.Filters, :delete_favourite_for_filter},
      url: "/rest/api/2/filter/#{id}/favourite",
      method: :delete,
      query: query,
      response: [{200, {Jira.Filter, :t}}, {400, :null}],
      opts: opts
    })
  end

  @doc """
  Delete filter

  Delete a filter.

  **[Permissions](#permissions) required:** Permission to access Jira, however filters can only be deleted by the creator of the filter or a user with *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec delete_filter(integer, keyword) :: :ok | :error
  def delete_filter(id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id],
      call: {Jira.Filters, :delete_filter},
      url: "/rest/api/2/filter/#{id}",
      method: :delete,
      response: [{204, :null}, {400, :null}, {401, :null}],
      opts: opts
    })
  end

  @doc """
  Get columns

  Returns the columns configured for a filter. The column configuration is used when the filter's results are viewed in *List View* with the *Columns* set to *Filter*.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** None, however, column details are only returned for:

   *  filters owned by the user.
   *  filters shared with a group that the user is a member of.
   *  filters shared with a private project that the user has *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for.
   *  filters shared with a public project.
   *  filters shared with the public.
  """
  @spec get_columns(integer, keyword) :: {:ok, [Jira.ColumnItem.t()]} | :error
  def get_columns(id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id],
      call: {Jira.Filters, :get_columns},
      url: "/rest/api/2/filter/#{id}/columns",
      method: :get,
      response: [{200, [{Jira.ColumnItem, :t}]}, {400, :null}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get favorite filters

  Returns the visible favorite filters of the user.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** A favorite filter is only visible to the user where the filter is:

   *  owned by the user.
   *  shared with a group that the user is a member of.
   *  shared with a private project that the user has *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for.
   *  shared with a public project.
   *  shared with the public.

  For example, if the user favorites a public filter that is subsequently made private that filter is not returned by this operation.

  ## Options

    * `expand`: Use [expand](#expansion) to include additional information about filter in the response. This parameter accepts a comma-separated list. Expand options include:
      
       *  `sharedUsers` Returns the users that the filter is shared with. This includes users that can browse projects that the filter is shared with. If you don't specify `sharedUsers`, then the `sharedUsers` object is returned but it doesn't list any users. The list of users returned is limited to 1000, to access additional users append `[start-index:end-index]` to the expand request. For example, to access the next 1000 users, use `?expand=sharedUsers[1001:2000]`.
       *  `subscriptions` Returns the users that are subscribed to the filter. If you don't specify `subscriptions`, the `subscriptions` object is returned but it doesn't list any subscriptions. The list of subscriptions returned is limited to 1000, to access additional subscriptions append `[start-index:end-index]` to the expand request. For example, to access the next 1000 subscriptions, use `?expand=subscriptions[1001:2000]`.

  """
  @spec get_favourite_filters(keyword) :: {:ok, [Jira.Filter.t()]} | :error
  def get_favourite_filters(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:expand])

    client.request(%{
      args: [],
      call: {Jira.Filters, :get_favourite_filters},
      url: "/rest/api/2/filter/favourite",
      method: :get,
      query: query,
      response: [{200, [{Jira.Filter, :t}]}, {401, :null}],
      opts: opts
    })
  end

  @doc """
  Get filter

  Returns a filter.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** None, however, the filter is only returned where it is:

   *  owned by the user.
   *  shared with a group that the user is a member of.
   *  shared with a private project that the user has *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for.
   *  shared with a public project.
   *  shared with the public.

  ## Options

    * `expand`: Use [expand](#expansion) to include additional information about filter in the response. This parameter accepts a comma-separated list. Expand options include:
      
       *  `sharedUsers` Returns the users that the filter is shared with. This includes users that can browse projects that the filter is shared with. If you don't specify `sharedUsers`, then the `sharedUsers` object is returned but it doesn't list any users. The list of users returned is limited to 1000, to access additional users append `[start-index:end-index]` to the expand request. For example, to access the next 1000 users, use `?expand=sharedUsers[1001:2000]`.
       *  `subscriptions` Returns the users that are subscribed to the filter. If you don't specify `subscriptions`, the `subscriptions` object is returned but it doesn't list any subscriptions. The list of subscriptions returned is limited to 1000, to access additional subscriptions append `[start-index:end-index]` to the expand request. For example, to access the next 1000 subscriptions, use `?expand=subscriptions[1001:2000]`.
    * `overrideSharePermissions`: EXPERIMENTAL: Whether share permissions are overridden to enable filters with any share permissions to be returned. Available to users with *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  """
  @spec get_filter(integer, keyword) :: {:ok, Jira.Filter.t()} | :error
  def get_filter(id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:expand, :overrideSharePermissions])

    client.request(%{
      args: [id: id],
      call: {Jira.Filters, :get_filter},
      url: "/rest/api/2/filter/#{id}",
      method: :get,
      query: query,
      response: [{200, {Jira.Filter, :t}}, {400, :null}, {401, :null}],
      opts: opts
    })
  end

  @doc """
  Search for filters

  Returns a [paginated](#pagination) list of filters. Use this operation to get:

   *  specific filters, by defining `id` only.
   *  filters that match all of the specified attributes. For example, all filters for a user with a particular word in their name. When multiple attributes are specified only filters matching all attributes are returned.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** None, however, only the following filters that match the query parameters are returned:

   *  filters owned by the user.
   *  filters shared with a group that the user is a member of.
   *  filters shared with a private project that the user has *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for.
   *  filters shared with a public project.
   *  filters shared with the public.

  ## Options

    * `filterName`: String used to perform a case-insensitive partial match with `name`.
    * `accountId`: User account ID used to return filters with the matching `owner.accountId`. This parameter cannot be used with `owner`.
    * `owner`: This parameter is deprecated because of privacy changes. Use `accountId` instead. See the [migration guide](https://developer.atlassian.com/cloud/jira/platform/deprecation-notice-user-privacy-api-migration-guide/) for details. User name used to return filters with the matching `owner.name`. This parameter cannot be used with `accountId`.
    * `groupname`: As a group's name can change, use of `groupId` is recommended to identify a group. Group name used to returns filters that are shared with a group that matches `sharePermissions.group.groupname`. This parameter cannot be used with the `groupId` parameter.
    * `groupId`: Group ID used to returns filters that are shared with a group that matches `sharePermissions.group.groupId`. This parameter cannot be used with the `groupname` parameter.
    * `projectId`: Project ID used to returns filters that are shared with a project that matches `sharePermissions.project.id`.
    * `id`: The list of filter IDs. To include multiple IDs, provide an ampersand-separated list. For example, `id=10000&id=10001`. Do not exceed 200 filter IDs.
    * `orderBy`: [Order](#ordering) the results by a field:
      
       *  `description` Sorts by filter description. Note that this sorting works independently of whether the expand to display the description field is in use.
       *  `favourite_count` Sorts by the count of how many users have this filter as a favorite.
       *  `is_favourite` Sorts by whether the filter is marked as a favorite.
       *  `id` Sorts by filter ID.
       *  `name` Sorts by filter name.
       *  `owner` Sorts by the ID of the filter owner.
       *  `is_shared` Sorts by whether the filter is shared.
    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.
    * `expand`: Use [expand](#expansion) to include additional information about filter in the response. This parameter accepts a comma-separated list. Expand options include:
      
       *  `description` Returns the description of the filter.
       *  `favourite` Returns an indicator of whether the user has set the filter as a favorite.
       *  `favouritedCount` Returns a count of how many users have set this filter as a favorite.
       *  `jql` Returns the JQL query that the filter uses.
       *  `owner` Returns the owner of the filter.
       *  `searchUrl` Returns a URL to perform the filter's JQL query.
       *  `sharePermissions` Returns the share permissions defined for the filter.
       *  `editPermissions` Returns the edit permissions defined for the filter.
       *  `isWritable` Returns whether the current user has permission to edit the filter.
       *  `approximateLastUsed` \[Experimental\] Returns the approximate date and time when the filter was last evaluated.
       *  `subscriptions` Returns the users that are subscribed to the filter.
       *  `viewUrl` Returns a URL to view the filter.
    * `overrideSharePermissions`: EXPERIMENTAL: Whether share permissions are overridden to enable filters with any share permissions to be returned. Available to users with *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  """
  @spec get_filters_paginated(keyword) ::
          {:ok, Jira.PageBeanFilterDetails.t()} | {:error, Jira.ErrorCollection.t()}
  def get_filters_paginated(opts \\ []) do
    client = opts[:client] || @default_client

    query =
      Keyword.take(opts, [
        :accountId,
        :expand,
        :filterName,
        :groupId,
        :groupname,
        :id,
        :maxResults,
        :orderBy,
        :overrideSharePermissions,
        :owner,
        :projectId,
        :startAt
      ])

    client.request(%{
      args: [],
      call: {Jira.Filters, :get_filters_paginated},
      url: "/rest/api/2/filter/search",
      method: :get,
      query: query,
      response: [
        {200, {Jira.PageBeanFilterDetails, :t}},
        {400, {Jira.ErrorCollection, :t}},
        {401, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Get my filters

  Returns the filters owned by the user. If `includeFavourites` is `true`, the user's visible favorite filters are also returned.

  **[Permissions](#permissions) required:** Permission to access Jira, however, a favorite filters is only visible to the user where the filter is:

   *  owned by the user.
   *  shared with a group that the user is a member of.
   *  shared with a private project that the user has *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for.
   *  shared with a public project.
   *  shared with the public.

  For example, if the user favorites a public filter that is subsequently made private that filter is not returned by this operation.

  ## Options

    * `expand`: Use [expand](#expansion) to include additional information about filter in the response. This parameter accepts a comma-separated list. Expand options include:
      
       *  `sharedUsers` Returns the users that the filter is shared with. This includes users that can browse projects that the filter is shared with. If you don't specify `sharedUsers`, then the `sharedUsers` object is returned but it doesn't list any users. The list of users returned is limited to 1000, to access additional users append `[start-index:end-index]` to the expand request. For example, to access the next 1000 users, use `?expand=sharedUsers[1001:2000]`.
       *  `subscriptions` Returns the users that are subscribed to the filter. If you don't specify `subscriptions`, the `subscriptions` object is returned but it doesn't list any subscriptions. The list of subscriptions returned is limited to 1000, to access additional subscriptions append `[start-index:end-index]` to the expand request. For example, to access the next 1000 subscriptions, use `?expand=subscriptions[1001:2000]`.
    * `includeFavourites`: Include the user's favorite filters in the response.

  """
  @spec get_my_filters(keyword) :: {:ok, [Jira.Filter.t()]} | :error
  def get_my_filters(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:expand, :includeFavourites])

    client.request(%{
      args: [],
      call: {Jira.Filters, :get_my_filters},
      url: "/rest/api/2/filter/my",
      method: :get,
      query: query,
      response: [{200, [{Jira.Filter, :t}]}, {401, :null}],
      opts: opts
    })
  end

  @doc """
  Reset columns

  Reset the user's column configuration for the filter to the default.

  **[Permissions](#permissions) required:** Permission to access Jira, however, columns are only reset for:

   *  filters owned by the user.
   *  filters shared with a group that the user is a member of.
   *  filters shared with a private project that the user has *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for.
   *  filters shared with a public project.
   *  filters shared with the public.
  """
  @spec reset_columns(integer, keyword) :: :ok | :error
  def reset_columns(id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id],
      call: {Jira.Filters, :reset_columns},
      url: "/rest/api/2/filter/#{id}/columns",
      method: :delete,
      response: [{204, :null}, {400, :null}, {401, :null}],
      opts: opts
    })
  end

  @doc """
  Set columns

  Sets the columns for a filter. Only navigable fields can be set as columns. Use [Get fields](#api-rest-api-2-field-get) to get the list fields in Jira. A navigable field has `navigable` set to `true`.

  The parameters for this resource are expressed as HTML form data. For example, in curl:

  `curl -X PUT -d columns=summary -d columns=description https://your-domain.atlassian.net/rest/api/2/filter/10000/columns`

  **[Permissions](#permissions) required:** Permission to access Jira, however, columns are only set for:

   *  filters owned by the user.
   *  filters shared with a group that the user is a member of.
   *  filters shared with a private project that the user has *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for.
   *  filters shared with a public project.
   *  filters shared with the public.
  """
  @spec set_columns(integer, Jira.ColumnRequestBody.t(), keyword) :: {:ok, map} | :error
  def set_columns(id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id, body: body],
      call: {Jira.Filters, :set_columns},
      url: "/rest/api/2/filter/#{id}/columns",
      body: body,
      method: :put,
      request: [
        {"*/*", {Jira.ColumnRequestBody, :t}},
        {"application/json", {Jira.ColumnRequestBody, :t}},
        {"multipart/form-data", {Jira.ColumnRequestBody, :t}}
      ],
      response: [{200, :map}, {400, :null}, {403, :null}],
      opts: opts
    })
  end

  @doc """
  Add filter as favorite

  Add a filter as a favorite for the user.

  **[Permissions](#permissions) required:** Permission to access Jira, however, the user can only favorite:

   *  filters owned by the user.
   *  filters shared with a group that the user is a member of.
   *  filters shared with a private project that the user has *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for.
   *  filters shared with a public project.
   *  filters shared with the public.

  ## Options

    * `expand`: Use [expand](#expansion) to include additional information about filter in the response. This parameter accepts a comma-separated list. Expand options include:
      
       *  `sharedUsers` Returns the users that the filter is shared with. This includes users that can browse projects that the filter is shared with. If you don't specify `sharedUsers`, then the `sharedUsers` object is returned but it doesn't list any users. The list of users returned is limited to 1000, to access additional users append `[start-index:end-index]` to the expand request. For example, to access the next 1000 users, use `?expand=sharedUsers[1001:2000]`.
       *  `subscriptions` Returns the users that are subscribed to the filter. If you don't specify `subscriptions`, the `subscriptions` object is returned but it doesn't list any subscriptions. The list of subscriptions returned is limited to 1000, to access additional subscriptions append `[start-index:end-index]` to the expand request. For example, to access the next 1000 subscriptions, use `?expand=subscriptions[1001:2000]`.

  """
  @spec set_favourite_for_filter(integer, keyword) :: {:ok, Jira.Filter.t()} | :error
  def set_favourite_for_filter(id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:expand])

    client.request(%{
      args: [id: id],
      call: {Jira.Filters, :set_favourite_for_filter},
      url: "/rest/api/2/filter/#{id}/favourite",
      method: :put,
      query: query,
      response: [{200, {Jira.Filter, :t}}, {400, :null}],
      opts: opts
    })
  end

  @doc """
  Update filter

  Updates a filter. Use this operation to update a filter's name, description, JQL, or sharing.

  **[Permissions](#permissions) required:** Permission to access Jira, however the user must own the filter.

  ## Options

    * `expand`: Use [expand](#expansion) to include additional information about filter in the response. This parameter accepts a comma-separated list. Expand options include:
      
       *  `sharedUsers` Returns the users that the filter is shared with. This includes users that can browse projects that the filter is shared with. If you don't specify `sharedUsers`, then the `sharedUsers` object is returned but it doesn't list any users. The list of users returned is limited to 1000, to access additional users append `[start-index:end-index]` to the expand request. For example, to access the next 1000 users, use `?expand=sharedUsers[1001:2000]`.
       *  `subscriptions` Returns the users that are subscribed to the filter. If you don't specify `subscriptions`, the `subscriptions` object is returned but it doesn't list any subscriptions. The list of subscriptions returned is limited to 1000, to access additional subscriptions append `[start-index:end-index]` to the expand request. For example, to access the next 1000 subscriptions, use `?expand=subscriptions[1001:2000]`.
    * `overrideSharePermissions`: EXPERIMENTAL: Whether share permissions are overridden to enable the addition of any share permissions to filters. Available to users with *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  """
  @spec update_filter(integer, Jira.Filter.t(), keyword) :: {:ok, Jira.Filter.t()} | :error
  def update_filter(id, body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:expand, :overrideSharePermissions])

    client.request(%{
      args: [id: id, body: body],
      call: {Jira.Filters, :update_filter},
      url: "/rest/api/2/filter/#{id}",
      body: body,
      method: :put,
      query: query,
      request: [{"application/json", {Jira.Filter, :t}}],
      response: [{200, {Jira.Filter, :t}}, {400, :null}, {401, :null}],
      opts: opts
    })
  end
end
