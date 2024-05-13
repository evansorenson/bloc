defmodule Jira.Dashboards do
  @moduledoc """
  Provides API endpoints related to dashboards
  """

  @default_client Jira.Client

  @doc """
  Add gadget to dashboard

  Adds a gadget to a dashboard.

  **[Permissions](#permissions) required:** None.
  """
  @spec add_gadget(integer, Jira.DashboardGadgetSettings.t(), keyword) ::
          {:ok, Jira.DashboardGadget.t()} | {:error, Jira.ErrorCollection.t()}
  def add_gadget(dashboardId, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [dashboardId: dashboardId, body: body],
      call: {Jira.Dashboards, :add_gadget},
      url: "/rest/api/2/dashboard/#{dashboardId}/gadget",
      body: body,
      method: :post,
      request: [{"application/json", {Jira.DashboardGadgetSettings, :t}}],
      response: [
        {200, {Jira.DashboardGadget, :t}},
        {400, {Jira.ErrorCollection, :t}},
        {401, :null},
        {404, {Jira.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Bulk edit dashboards

  Bulk edit dashboards. Maximum number of dashboards to be edited at the same time is 100.

  **[Permissions](#permissions) required:** None

  The dashboards to be updated must be owned by the user, or the user must be an administrator.
  """
  @spec bulk_edit_dashboards(Jira.BulkEditShareableEntityRequest.t(), keyword) ::
          {:ok, Jira.BulkEditShareableEntityResponse.t()} | {:error, Jira.ErrorCollection.t()}
  def bulk_edit_dashboards(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jira.Dashboards, :bulk_edit_dashboards},
      url: "/rest/api/2/dashboard/bulk/edit",
      body: body,
      method: :put,
      request: [{"application/json", {Jira.BulkEditShareableEntityRequest, :t}}],
      response: [
        {200, {Jira.BulkEditShareableEntityResponse, :t}},
        {400, {Jira.ErrorCollection, :t}},
        {401, {Jira.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Copy dashboard

  Copies a dashboard. Any values provided in the `dashboard` parameter replace those in the copied dashboard.

  **[Permissions](#permissions) required:** None

  The dashboard to be copied must be owned by or shared with the user.
  """
  @spec copy_dashboard(String.t(), Jira.DashboardDetails.t(), keyword) ::
          {:ok, Jira.Dashboard.t()} | {:error, Jira.ErrorCollection.t()}
  def copy_dashboard(id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id, body: body],
      call: {Jira.Dashboards, :copy_dashboard},
      url: "/rest/api/2/dashboard/#{id}/copy",
      body: body,
      method: :post,
      request: [{"application/json", {Jira.DashboardDetails, :t}}],
      response: [
        {200, {Jira.Dashboard, :t}},
        {400, {Jira.ErrorCollection, :t}},
        {401, {Jira.ErrorCollection, :t}},
        {404, {Jira.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Create dashboard

  Creates a dashboard.

  **[Permissions](#permissions) required:** None.
  """
  @spec create_dashboard(Jira.DashboardDetails.t(), keyword) ::
          {:ok, Jira.Dashboard.t()} | {:error, Jira.ErrorCollection.t()}
  def create_dashboard(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jira.Dashboards, :create_dashboard},
      url: "/rest/api/2/dashboard",
      body: body,
      method: :post,
      request: [{"application/json", {Jira.DashboardDetails, :t}}],
      response: [
        {200, {Jira.Dashboard, :t}},
        {400, {Jira.ErrorCollection, :t}},
        {401, {Jira.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Delete dashboard

  Deletes a dashboard.

  **[Permissions](#permissions) required:** None

  The dashboard to be deleted must be owned by the user.
  """
  @spec delete_dashboard(String.t(), keyword) :: :ok | {:error, Jira.ErrorCollection.t()}
  def delete_dashboard(id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id],
      call: {Jira.Dashboards, :delete_dashboard},
      url: "/rest/api/2/dashboard/#{id}",
      method: :delete,
      response: [
        {204, :null},
        {400, {Jira.ErrorCollection, :t}},
        {401, {Jira.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Delete dashboard item property

  Deletes a dashboard item property.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** The user must be the owner of the dashboard. Note, users with the *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg) are considered owners of the System dashboard.
  """
  @spec delete_dashboard_item_property(String.t(), String.t(), String.t(), keyword) ::
          {:ok, map} | {:error, Jira.ErrorCollection.t()}
  def delete_dashboard_item_property(dashboardId, itemId, propertyKey, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [dashboardId: dashboardId, itemId: itemId, propertyKey: propertyKey],
      call: {Jira.Dashboards, :delete_dashboard_item_property},
      url: "/rest/api/2/dashboard/#{dashboardId}/items/#{itemId}/properties/#{propertyKey}",
      method: :delete,
      response: [
        {204, :map},
        {400, {Jira.ErrorCollection, :t}},
        {401, {Jira.ErrorCollection, :t}},
        {403, {Jira.ErrorCollection, :t}},
        {404, {Jira.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get available gadgets

  Gets a list of all available gadgets that can be added to all dashboards.

  **[Permissions](#permissions) required:** None.
  """
  @spec get_all_available_dashboard_gadgets(keyword) ::
          {:ok, Jira.AvailableDashboardGadgetsResponse.t()} | {:error, Jira.ErrorCollection.t()}
  def get_all_available_dashboard_gadgets(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Jira.Dashboards, :get_all_available_dashboard_gadgets},
      url: "/rest/api/2/dashboard/gadgets",
      method: :get,
      response: [
        {200, {Jira.AvailableDashboardGadgetsResponse, :t}},
        {400, {Jira.ErrorCollection, :t}},
        {401, {Jira.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get all dashboards

  Returns a list of dashboards owned by or shared with the user. The list may be filtered to include only favorite or owned dashboards.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** None.

  ## Options

    * `filter`: The filter applied to the list of dashboards. Valid values are:
      
       *  `favourite` Returns dashboards the user has marked as favorite.
       *  `my` Returns dashboards owned by the user.
    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.

  """
  @spec get_all_dashboards(keyword) ::
          {:ok, Jira.PageOfDashboards.t()} | {:error, Jira.ErrorCollection.t()}
  def get_all_dashboards(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:filter, :maxResults, :startAt])

    client.request(%{
      args: [],
      call: {Jira.Dashboards, :get_all_dashboards},
      url: "/rest/api/2/dashboard",
      method: :get,
      query: query,
      response: [
        {200, {Jira.PageOfDashboards, :t}},
        {400, {Jira.ErrorCollection, :t}},
        {401, {Jira.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get gadgets

  Returns a list of dashboard gadgets on a dashboard.

  This operation returns:

   *  Gadgets from a list of IDs, when `id` is set.
   *  Gadgets with a module key, when `moduleKey` is set.
   *  Gadgets from a list of URIs, when `uri` is set.
   *  All gadgets, when no other parameters are set.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** None.

  ## Options

    * `moduleKey`: The list of gadgets module keys. To include multiple module keys, separate module keys with ampersand: `moduleKey=key:one&moduleKey=key:two`.
    * `uri`: The list of gadgets URIs. To include multiple URIs, separate URIs with ampersand: `uri=/rest/example/uri/1&uri=/rest/example/uri/2`.
    * `gadgetId`: The list of gadgets IDs. To include multiple IDs, separate IDs with ampersand: `gadgetId=10000&gadgetId=10001`.

  """
  @spec get_all_gadgets(integer, keyword) ::
          {:ok, Jira.DashboardGadgetResponse.t()} | {:error, Jira.ErrorCollection.t()}
  def get_all_gadgets(dashboardId, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:gadgetId, :moduleKey, :uri])

    client.request(%{
      args: [dashboardId: dashboardId],
      call: {Jira.Dashboards, :get_all_gadgets},
      url: "/rest/api/2/dashboard/#{dashboardId}/gadget",
      method: :get,
      query: query,
      response: [
        {200, {Jira.DashboardGadgetResponse, :t}},
        {401, :null},
        {404, {Jira.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get dashboard

  Returns a dashboard.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** None.

  However, to get a dashboard, the dashboard must be shared with the user or the user must own it. Note, users with the *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg) are considered owners of the System dashboard. The System dashboard is considered to be shared with all other users.
  """
  @spec get_dashboard(String.t(), keyword) ::
          {:ok, Jira.Dashboard.t()} | {:error, Jira.ErrorCollection.t()}
  def get_dashboard(id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id],
      call: {Jira.Dashboards, :get_dashboard},
      url: "/rest/api/2/dashboard/#{id}",
      method: :get,
      response: [
        {200, {Jira.Dashboard, :t}},
        {400, {Jira.ErrorCollection, :t}},
        {401, {Jira.ErrorCollection, :t}},
        {404, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Get dashboard item property

  Returns the key and value of a dashboard item property.

  A dashboard item enables an app to add user-specific information to a user dashboard. Dashboard items are exposed to users as gadgets that users can add to their dashboards. For more information on how users do this, see [Adding and customizing gadgets](https://confluence.atlassian.com/x/7AeiLQ).

  When an app creates a dashboard item it registers a callback to receive the dashboard item ID. The callback fires whenever the item is rendered or, where the item is configurable, the user edits the item. The app then uses this resource to store the item's content or configuration details. For more information on working with dashboard items, see [ Building a dashboard item for a JIRA Connect add-on](https://developer.atlassian.com/server/jira/platform/guide-building-a-dashboard-item-for-a-jira-connect-add-on-33746254/) and the [Dashboard Item](https://developer.atlassian.com/cloud/jira/platform/modules/dashboard-item/) documentation.

  There is no resource to set or get dashboard items.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** The user must be the owner of the dashboard or have the dashboard shared with them. Note, users with the *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg) are considered owners of the System dashboard. The System dashboard is considered to be shared with all other users, and is accessible to anonymous users when Jira\\u2019s anonymous access is permitted.
  """
  @spec get_dashboard_item_property(String.t(), String.t(), String.t(), keyword) ::
          {:ok, Jira.EntityProperty.t()} | {:error, Jira.ErrorCollection.t()}
  def get_dashboard_item_property(dashboardId, itemId, propertyKey, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [dashboardId: dashboardId, itemId: itemId, propertyKey: propertyKey],
      call: {Jira.Dashboards, :get_dashboard_item_property},
      url: "/rest/api/2/dashboard/#{dashboardId}/items/#{itemId}/properties/#{propertyKey}",
      method: :get,
      response: [
        {200, {Jira.EntityProperty, :t}},
        {401, {Jira.ErrorCollection, :t}},
        {404, {Jira.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get dashboard item property keys

  Returns the keys of all properties for a dashboard item.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** The user must be the owner of the dashboard or have the dashboard shared with them. Note, users with the *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg) are considered owners of the System dashboard. The System dashboard is considered to be shared with all other users, and is accessible to anonymous users when Jira\\u2019s anonymous access is permitted.
  """
  @spec get_dashboard_item_property_keys(String.t(), String.t(), keyword) ::
          {:ok, Jira.PropertyKeys.t()} | {:error, Jira.ErrorCollection.t()}
  def get_dashboard_item_property_keys(dashboardId, itemId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [dashboardId: dashboardId, itemId: itemId],
      call: {Jira.Dashboards, :get_dashboard_item_property_keys},
      url: "/rest/api/2/dashboard/#{dashboardId}/items/#{itemId}/properties",
      method: :get,
      response: [
        {200, {Jira.PropertyKeys, :t}},
        {401, {Jira.ErrorCollection, :t}},
        {404, {Jira.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Search for dashboards

  Returns a [paginated](#pagination) list of dashboards. This operation is similar to [Get dashboards](#api-rest-api-2-dashboard-get) except that the results can be refined to include dashboards that have specific attributes. For example, dashboards with a particular name. When multiple attributes are specified only filters matching all attributes are returned.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** The following dashboards that match the query parameters are returned:

   *  Dashboards owned by the user. Not returned for anonymous users.
   *  Dashboards shared with a group that the user is a member of. Not returned for anonymous users.
   *  Dashboards shared with a private project that the user can browse. Not returned for anonymous users.
   *  Dashboards shared with a public project.
   *  Dashboards shared with the public.

  ## Options

    * `dashboardName`: String used to perform a case-insensitive partial match with `name`.
    * `accountId`: User account ID used to return dashboards with the matching `owner.accountId`. This parameter cannot be used with the `owner` parameter.
    * `owner`: This parameter is deprecated because of privacy changes. Use `accountId` instead. See the [migration guide](https://developer.atlassian.com/cloud/jira/platform/deprecation-notice-user-privacy-api-migration-guide/) for details. User name used to return dashboards with the matching `owner.name`. This parameter cannot be used with the `accountId` parameter.
    * `groupname`: As a group's name can change, use of `groupId` is recommended. Group name used to return dashboards that are shared with a group that matches `sharePermissions.group.name`. This parameter cannot be used with the `groupId` parameter.
    * `groupId`: Group ID used to return dashboards that are shared with a group that matches `sharePermissions.group.groupId`. This parameter cannot be used with the `groupname` parameter.
    * `projectId`: Project ID used to returns dashboards that are shared with a project that matches `sharePermissions.project.id`.
    * `orderBy`: [Order](#ordering) the results by a field:
      
       *  `description` Sorts by dashboard description. Note that this sort works independently of whether the expand to display the description field is in use.
       *  `favourite_count` Sorts by dashboard popularity.
       *  `id` Sorts by dashboard ID.
       *  `is_favourite` Sorts by whether the dashboard is marked as a favorite.
       *  `name` Sorts by dashboard name.
       *  `owner` Sorts by dashboard owner name.
    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.
    * `status`: The status to filter by. It may be active, archived or deleted.
    * `expand`: Use [expand](#expansion) to include additional information about dashboard in the response. This parameter accepts a comma-separated list. Expand options include:
      
       *  `description` Returns the description of the dashboard.
       *  `owner` Returns the owner of the dashboard.
       *  `viewUrl` Returns the URL that is used to view the dashboard.
       *  `favourite` Returns `isFavourite`, an indicator of whether the user has set the dashboard as a favorite.
       *  `favouritedCount` Returns `popularity`, a count of how many users have set this dashboard as a favorite.
       *  `sharePermissions` Returns details of the share permissions defined for the dashboard.
       *  `editPermissions` Returns details of the edit permissions defined for the dashboard.
       *  `isWritable` Returns whether the current user has permission to edit the dashboard.

  """
  @spec get_dashboards_paginated(keyword) ::
          {:ok, Jira.PageBeanDashboard.t()} | {:error, Jira.ErrorCollection.t()}
  def get_dashboards_paginated(opts \\ []) do
    client = opts[:client] || @default_client

    query =
      Keyword.take(opts, [
        :accountId,
        :dashboardName,
        :expand,
        :groupId,
        :groupname,
        :maxResults,
        :orderBy,
        :owner,
        :projectId,
        :startAt,
        :status
      ])

    client.request(%{
      args: [],
      call: {Jira.Dashboards, :get_dashboards_paginated},
      url: "/rest/api/2/dashboard/search",
      method: :get,
      query: query,
      response: [
        {200, {Jira.PageBeanDashboard, :t}},
        {400, {Jira.ErrorCollection, :t}},
        {401, {Jira.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Remove gadget from dashboard

  Removes a dashboard gadget from a dashboard.

  When a gadget is removed from a dashboard, other gadgets in the same column are moved up to fill the emptied position.

  **[Permissions](#permissions) required:** None.
  """
  @spec remove_gadget(integer, integer, keyword) ::
          {:ok, map} | {:error, Jira.ErrorCollection.t()}
  def remove_gadget(dashboardId, gadgetId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [dashboardId: dashboardId, gadgetId: gadgetId],
      call: {Jira.Dashboards, :remove_gadget},
      url: "/rest/api/2/dashboard/#{dashboardId}/gadget/#{gadgetId}",
      method: :delete,
      response: [{204, :map}, {401, :null}, {404, {Jira.ErrorCollection, :t}}],
      opts: opts
    })
  end

  @doc """
  Set dashboard item property

  Sets the value of a dashboard item property. Use this resource in apps to store custom data against a dashboard item.

  A dashboard item enables an app to add user-specific information to a user dashboard. Dashboard items are exposed to users as gadgets that users can add to their dashboards. For more information on how users do this, see [Adding and customizing gadgets](https://confluence.atlassian.com/x/7AeiLQ).

  When an app creates a dashboard item it registers a callback to receive the dashboard item ID. The callback fires whenever the item is rendered or, where the item is configurable, the user edits the item. The app then uses this resource to store the item's content or configuration details. For more information on working with dashboard items, see [ Building a dashboard item for a JIRA Connect add-on](https://developer.atlassian.com/server/jira/platform/guide-building-a-dashboard-item-for-a-jira-connect-add-on-33746254/) and the [Dashboard Item](https://developer.atlassian.com/cloud/jira/platform/modules/dashboard-item/) documentation.

  There is no resource to set or get dashboard items.

  The value of the request body must be a [valid](http://tools.ietf.org/html/rfc4627), non-empty JSON blob. The maximum length is 32768 characters.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** The user must be the owner of the dashboard. Note, users with the *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg) are considered owners of the System dashboard.
  """
  @spec set_dashboard_item_property(String.t(), String.t(), String.t(), map, keyword) ::
          {:ok, map} | {:error, Jira.ErrorCollection.t()}
  def set_dashboard_item_property(dashboardId, itemId, propertyKey, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [dashboardId: dashboardId, itemId: itemId, propertyKey: propertyKey, body: body],
      call: {Jira.Dashboards, :set_dashboard_item_property},
      url: "/rest/api/2/dashboard/#{dashboardId}/items/#{itemId}/properties/#{propertyKey}",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [
        {200, :map},
        {201, :map},
        {400, {Jira.ErrorCollection, :t}},
        {401, {Jira.ErrorCollection, :t}},
        {403, {Jira.ErrorCollection, :t}},
        {404, {Jira.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Update dashboard

  Updates a dashboard, replacing all the dashboard details with those provided.

  **[Permissions](#permissions) required:** None

  The dashboard to be updated must be owned by the user.
  """
  @spec update_dashboard(String.t(), Jira.DashboardDetails.t(), keyword) ::
          {:ok, Jira.Dashboard.t()} | {:error, Jira.ErrorCollection.t()}
  def update_dashboard(id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id, body: body],
      call: {Jira.Dashboards, :update_dashboard},
      url: "/rest/api/2/dashboard/#{id}",
      body: body,
      method: :put,
      request: [{"application/json", {Jira.DashboardDetails, :t}}],
      response: [
        {200, {Jira.Dashboard, :t}},
        {400, {Jira.ErrorCollection, :t}},
        {401, {Jira.ErrorCollection, :t}},
        {404, {Jira.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Update gadget on dashboard

  Changes the title, position, and color of the gadget on a dashboard.

  **[Permissions](#permissions) required:** None.
  """
  @spec update_gadget(integer, integer, Jira.DashboardGadgetUpdateRequest.t(), keyword) ::
          {:ok, map} | {:error, Jira.ErrorCollection.t()}
  def update_gadget(dashboardId, gadgetId, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [dashboardId: dashboardId, gadgetId: gadgetId, body: body],
      call: {Jira.Dashboards, :update_gadget},
      url: "/rest/api/2/dashboard/#{dashboardId}/gadget/#{gadgetId}",
      body: body,
      method: :put,
      request: [{"application/json", {Jira.DashboardGadgetUpdateRequest, :t}}],
      response: [
        {204, :map},
        {400, {Jira.ErrorCollection, :t}},
        {401, :null},
        {404, {Jira.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end
end
