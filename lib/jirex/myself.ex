defmodule Jirex.Myself do
  @moduledoc """
  Provides API endpoints related to myself
  """

  @default_client Jirex.Client

  @doc """
  Delete locale

  Deprecated, use [ Update a user profile](https://developer.atlassian.com/cloud/admin/user-management/rest/#api-users-account-id-manage-profile-patch) from the user management REST API instead.

  Deletes the locale of the user, which restores the default setting.

  **[Permissions](#permissions) required:** Permission to access Jira.
  """
  @spec delete_locale(keyword) :: {:ok, map} | :error
  def delete_locale(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Jirex.Myself, :delete_locale},
      url: "/rest/api/2/mypreferences/locale",
      method: :delete,
      response: [{204, :map}, {401, :null}],
      opts: opts
    })
  end

  @doc """
  Get current user

  Returns details for the current user.

  **[Permissions](#permissions) required:** Permission to access Jira.

  ## Options

    * `expand`: Use [expand](#expansion) to include additional information about user in the response. This parameter accepts a comma-separated list. Expand options include:

       *  `groups` Returns all groups, including nested groups, the user belongs to.
       *  `applicationRoles` Returns the application roles the user is assigned to.

  """
  @spec get_current_user(keyword) :: {:ok, Jirex.User.t()} | :error
  def get_current_user(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:expand])

    client.request(%{
      args: [],
      call: {Jirex.Myself, :get_current_user},
      url: "/rest/api/2/myself",
      method: :get,
      query: query,
      response: [{200, {Jirex.User, :t}}, {401, :null}],
      opts: opts
    })
  end

  @doc """
  Get locale

  Returns the locale for the user.

  If the user has no language preference set (which is the default setting) or this resource is accessed anonymous, the browser locale detected by Jira is returned. Jira detects the browser locale using the *Accept-Language* header in the request. However, if this doesn't match a locale available Jira, the site default locale is returned.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** None.
  """
  @spec get_locale(keyword) :: {:ok, Jirex.Locale.t()} | :error
  def get_locale(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Jirex.Myself, :get_locale},
      url: "/rest/api/2/mypreferences/locale",
      method: :get,
      response: [{200, {Jirex.Locale, :t}}, {401, :null}],
      opts: opts
    })
  end

  @doc """
  Get preference

  Returns the value of a preference of the current user.

  Note that these keys are deprecated:

   *  *jira.user.locale* The locale of the user. By default this is not set and the user takes the locale of the instance.
   *  *jira.user.timezone* The time zone of the user. By default this is not set and the user takes the timezone of the instance.

  These system preferences keys will be deprecated by 15/07/2024. You can still retrieve these keys, but it will not have any impact on Notification behaviour.

   *  *user.notifications.watcher* Whether the user gets notified when they are watcher.
   *  *user.notifications.assignee* Whether the user gets notified when they are assignee.
   *  *user.notifications.reporter* Whether the user gets notified when they are reporter.
   *  *user.notifications.mentions* Whether the user gets notified when they are mentions.

  Use [ Update a user profile](https://developer.atlassian.com/cloud/admin/user-management/rest/#api-users-account-id-manage-profile-patch) from the user management REST API to manage timezone and locale instead.

  **[Permissions](#permissions) required:** Permission to access Jira.

  ## Options

    * `key`: The key of the preference.

  """
  @spec get_preference(keyword) :: {:ok, String.t()} | :error
  def get_preference(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:key])

    client.request(%{
      args: [],
      call: {Jirex.Myself, :get_preference},
      url: "/rest/api/2/mypreferences",
      method: :get,
      query: query,
      response: [{200, {:string, :generic}}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Delete preference

  Deletes a preference of the user, which restores the default value of system defined settings.

  Note that these keys are deprecated:

   *  *jira.user.locale* The locale of the user. By default, not set. The user takes the instance locale.
   *  *jira.user.timezone* The time zone of the user. By default, not set. The user takes the instance timezone.

  Use [ Update a user profile](https://developer.atlassian.com/cloud/admin/user-management/rest/#api-users-account-id-manage-profile-patch) from the user management REST API to manage timezone and locale instead.

  **[Permissions](#permissions) required:** Permission to access Jira.

  ## Options

    * `key`: The key of the preference.

  """
  @spec remove_preference(keyword) :: :ok | :error
  def remove_preference(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:key])

    client.request(%{
      args: [],
      call: {Jirex.Myself, :remove_preference},
      url: "/rest/api/2/mypreferences",
      method: :delete,
      query: query,
      response: [{204, :null}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Set locale

  Deprecated, use [ Update a user profile](https://developer.atlassian.com/cloud/admin/user-management/rest/#api-users-account-id-manage-profile-patch) from the user management REST API instead.

  Sets the locale of the user. The locale must be one supported by the instance of Jira.

  **[Permissions](#permissions) required:** Permission to access Jira.
  """
  @spec set_locale(Jirex.Locale.t(), keyword) :: {:ok, map} | :error
  def set_locale(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jirex.Myself, :set_locale},
      url: "/rest/api/2/mypreferences/locale",
      body: body,
      method: :put,
      request: [{"application/json", {Jirex.Locale, :t}}],
      response: [{204, :map}, {400, :null}, {401, :null}],
      opts: opts
    })
  end

  @doc """
  Set preference

  Creates a preference for the user or updates a preference's value by sending a plain text string. For example, `false`. An arbitrary preference can be created with the value containing up to 255 characters. In addition, the following keys define system preferences that can be set or created:

   *  *user.notifications.mimetype* The mime type used in notifications sent to the user. Defaults to `html`.
   *  *user.default.share.private* Whether new [ filters](https://confluence.atlassian.com/x/eQiiLQ) are set to private. Defaults to `true`.
   *  *user.keyboard.shortcuts.disabled* Whether keyboard shortcuts are disabled. Defaults to `false`.
   *  *user.autowatch.disabled* Whether the user automatically watches issues they create or add a comment to. By default, not set: the user takes the instance autowatch setting.
   *  *user.notifiy.own.changes* Whether the user gets notified of their own changes.

  Note that these keys are deprecated:

   *  *jira.user.locale* The locale of the user. By default, not set. The user takes the instance locale.
   *  *jira.user.timezone* The time zone of the user. By default, not set. The user takes the instance timezone.

  These system preferences keys will be deprecated by 15/07/2024. You can still use these keys to create arbitrary preferences, but it will not have any impact on Notification behaviour.

   *  *user.notifications.watcher* Whether the user gets notified when they are watcher.
   *  *user.notifications.assignee* Whether the user gets notified when they are assignee.
   *  *user.notifications.reporter* Whether the user gets notified when they are reporter.
   *  *user.notifications.mentions* Whether the user gets notified when they are mentions.

  Use [ Update a user profile](https://developer.atlassian.com/cloud/admin/user-management/rest/#api-users-account-id-manage-profile-patch) from the user management REST API to manage timezone and locale instead.

  **[Permissions](#permissions) required:** Permission to access Jira.

  ## Options

    * `key`: The key of the preference. The maximum length is 255 characters.

  """
  @spec set_preference(String.t(), keyword) :: {:ok, map} | :error
  def set_preference(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:key])

    client.request(%{
      args: [body: body],
      call: {Jirex.Myself, :set_preference},
      url: "/rest/api/2/mypreferences",
      body: body,
      method: :put,
      query: query,
      request: [{"application/json", {:string, :generic}}, {"text/plain", {:string, :generic}}],
      response: [{204, :map}, {401, :null}, {404, :null}],
      opts: opts
    })
  end
end
