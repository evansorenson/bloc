defmodule Jirex.IssueNotificationSchemes do
  @moduledoc """
  Provides API endpoints related to issue notification schemes
  """

  @default_client Jirex.Client

  @doc """
  Add notifications to notification scheme

  Adds notifications to a notification scheme. You can add up to 1000 notifications per request.

  *Deprecated: The notification type `EmailAddress` is no longer supported in Cloud. Refer to the [changelog](https://developer.atlassian.com/cloud/jira/platform/changelog/#CHANGE-1031) for more details.*

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec add_notifications(String.t(), Jirex.AddNotificationsDetails.t(), keyword) ::
          {:ok, map} | {:error, Jirex.ErrorCollection.t()}
  def add_notifications(id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id, body: body],
      call: {Jirex.IssueNotificationSchemes, :add_notifications},
      url: "/rest/api/2/notificationscheme/#{id}/notification",
      body: body,
      method: :put,
      request: [{"application/json", {Jirex.AddNotificationsDetails, :t}}],
      response: [
        {204, :map},
        {400, {Jirex.ErrorCollection, :t}},
        {401, {Jirex.ErrorCollection, :t}},
        {403, {Jirex.ErrorCollection, :t}},
        {404, {Jirex.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Create notification scheme

  Creates a notification scheme with notifications. You can create up to 1000 notifications per request.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec create_notification_scheme(Jirex.CreateNotificationSchemeDetails.t(), keyword) ::
          {:ok, Jirex.NotificationSchemeId.t()} | {:error, Jirex.ErrorCollection.t()}
  def create_notification_scheme(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jirex.IssueNotificationSchemes, :create_notification_scheme},
      url: "/rest/api/2/notificationscheme",
      body: body,
      method: :post,
      request: [{"application/json", {Jirex.CreateNotificationSchemeDetails, :t}}],
      response: [
        {201, {Jirex.NotificationSchemeId, :t}},
        {400, {Jirex.ErrorCollection, :t}},
        {401, {Jirex.ErrorCollection, :t}},
        {403, {Jirex.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Delete notification scheme

  Deletes a notification scheme.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec delete_notification_scheme(String.t(), keyword) ::
          {:ok, map} | {:error, Jirex.ErrorCollection.t()}
  def delete_notification_scheme(notificationSchemeId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [notificationSchemeId: notificationSchemeId],
      call: {Jirex.IssueNotificationSchemes, :delete_notification_scheme},
      url: "/rest/api/2/notificationscheme/#{notificationSchemeId}",
      method: :delete,
      response: [
        {204, :map},
        {400, {Jirex.ErrorCollection, :t}},
        {401, {Jirex.ErrorCollection, :t}},
        {403, {Jirex.ErrorCollection, :t}},
        {404, {Jirex.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get notification scheme

  Returns a [notification scheme](https://confluence.atlassian.com/x/8YdKLg), including the list of events and the recipients who will receive notifications for those events.

  **[Permissions](#permissions) required:** Permission to access Jira, however, the user must have permission to administer at least one project associated with the notification scheme.

  ## Options

    * `expand`: Use [expand](#expansion) to include additional information in the response. This parameter accepts a comma-separated list. Expand options include:

       *  `all` Returns all expandable information
       *  `field` Returns information about any custom fields assigned to receive an event
       *  `group` Returns information about any groups assigned to receive an event
       *  `notificationSchemeEvents` Returns a list of event associations. This list is returned for all expandable information
       *  `projectRole` Returns information about any project roles assigned to receive an event
       *  `user` Returns information about any users assigned to receive an event

  """
  @spec get_notification_scheme(integer, keyword) :: {:ok, Jirex.NotificationScheme.t()} | :error
  def get_notification_scheme(id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:expand])

    client.request(%{
      args: [id: id],
      call: {Jirex.IssueNotificationSchemes, :get_notification_scheme},
      url: "/rest/api/2/notificationscheme/#{id}",
      method: :get,
      query: query,
      response: [{200, {Jirex.NotificationScheme, :t}}, {400, :null}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get projects using notification schemes paginated

  Returns a [paginated](#pagination) mapping of project that have notification scheme assigned. You can provide either one or multiple notification scheme IDs or project IDs to filter by. If you don't provide any, this will return a list of all mappings. Note that only company-managed (classic) projects are supported. This is because team-managed projects don't have a concept of a default notification scheme. The mappings are ordered by projectId.

  **[Permissions](#permissions) required:** Permission to access Jira.

  ## Options

    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.
    * `notificationSchemeId`: The list of notifications scheme IDs to be filtered out
    * `projectId`: The list of project IDs to be filtered out

  """
  @spec get_notification_scheme_to_project_mappings(keyword) ::
          {:ok, Jirex.PageBeanNotificationSchemeAndProjectMappingJsonBean.t()}
          | {:error, Jirex.ErrorCollection.t()}
  def get_notification_scheme_to_project_mappings(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:maxResults, :notificationSchemeId, :projectId, :startAt])

    client.request(%{
      args: [],
      call: {Jirex.IssueNotificationSchemes, :get_notification_scheme_to_project_mappings},
      url: "/rest/api/2/notificationscheme/project",
      method: :get,
      query: query,
      response: [
        {200, {Jirex.PageBeanNotificationSchemeAndProjectMappingJsonBean, :t}},
        {400, {Jirex.ErrorCollection, :t}},
        {401, {Jirex.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get notification schemes paginated

  Returns a [paginated](#pagination) list of [notification schemes](https://confluence.atlassian.com/x/8YdKLg) ordered by the display name.

  *Note that you should allow for events without recipients to appear in responses.*

  **[Permissions](#permissions) required:** Permission to access Jira, however, the user must have permission to administer at least one project associated with a notification scheme for it to be returned.

  ## Options

    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.
    * `id`: The list of notification schemes IDs to be filtered by
    * `projectId`: The list of projects IDs to be filtered by
    * `onlyDefault`: When set to true, returns only the default notification scheme. If you provide project IDs not associated with the default, returns an empty page. The default value is false.
    * `expand`: Use [expand](#expansion) to include additional information in the response. This parameter accepts a comma-separated list. Expand options include:

       *  `all` Returns all expandable information
       *  `field` Returns information about any custom fields assigned to receive an event
       *  `group` Returns information about any groups assigned to receive an event
       *  `notificationSchemeEvents` Returns a list of event associations. This list is returned for all expandable information
       *  `projectRole` Returns information about any project roles assigned to receive an event
       *  `user` Returns information about any users assigned to receive an event

  """
  @spec get_notification_schemes(keyword) ::
          {:ok, Jirex.PageBeanNotificationScheme.t()} | {:error, any}
  def get_notification_schemes(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:expand, :id, :maxResults, :onlyDefault, :projectId, :startAt])

    client.request(%{
      args: [],
      call: {Jirex.IssueNotificationSchemes, :get_notification_schemes},
      url: "/rest/api/2/notificationscheme",
      method: :get,
      query: query,
      response: [{200, {Jirex.PageBeanNotificationScheme, :t}}, {400, :unknown}, {401, :null}],
      opts: opts
    })
  end

  @doc """
  Remove notification from notification scheme

  Removes a notification from a notification scheme.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec remove_notification_from_notification_scheme(String.t(), String.t(), keyword) ::
          {:ok, map} | {:error, Jirex.ErrorCollection.t()}
  def remove_notification_from_notification_scheme(
        notificationSchemeId,
        notificationId,
        opts \\ []
      ) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [notificationSchemeId: notificationSchemeId, notificationId: notificationId],
      call: {Jirex.IssueNotificationSchemes, :remove_notification_from_notification_scheme},
      url:
        "/rest/api/2/notificationscheme/#{notificationSchemeId}/notification/#{notificationId}",
      method: :delete,
      response: [
        {204, :map},
        {400, {Jirex.ErrorCollection, :t}},
        {401, {Jirex.ErrorCollection, :t}},
        {403, {Jirex.ErrorCollection, :t}},
        {404, {Jirex.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Update notification scheme

  Updates a notification scheme.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec update_notification_scheme(String.t(), Jirex.UpdateNotificationSchemeDetails.t(), keyword) ::
          {:ok, map} | {:error, Jirex.ErrorCollection.t()}
  def update_notification_scheme(id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id, body: body],
      call: {Jirex.IssueNotificationSchemes, :update_notification_scheme},
      url: "/rest/api/2/notificationscheme/#{id}",
      body: body,
      method: :put,
      request: [{"application/json", {Jirex.UpdateNotificationSchemeDetails, :t}}],
      response: [
        {204, :map},
        {400, {Jirex.ErrorCollection, :t}},
        {401, {Jirex.ErrorCollection, :t}},
        {403, {Jirex.ErrorCollection, :t}},
        {404, {Jirex.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end
end
