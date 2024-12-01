defmodule Jirex.IssueWatchers do
  @moduledoc """
  Provides API endpoints related to issue watchers
  """

  @default_client Jirex.Client

  @doc """
  Add watcher

  Adds a user as a watcher of an issue by passing the account ID of the user. For example, `"5b10ac8d82e05b22cc7d4ef5"`. If no user is specified the calling user is added.

  This operation requires the **Allow users to watch issues** option to be *ON*. This option is set in General configuration for Jira. See [Configuring Jira application options](https://confluence.atlassian.com/x/uYXKM) for details.

  **[Permissions](#permissions) required:**

   *  *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project that the issue is in.
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is configured, issue-level security permission to view the issue.
   *  To add users other than themselves to the watchlist, *Manage watcher list* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project that the issue is in.
  """
  @spec add_watcher(String.t(), String.t(), keyword) :: {:ok, map} | :error
  def add_watcher(issueIdOrKey, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [issueIdOrKey: issueIdOrKey, body: body],
      call: {Jirex.IssueWatchers, :add_watcher},
      url: "/rest/api/2/issue/#{issueIdOrKey}/watchers",
      body: body,
      method: :post,
      request: [{"application/json", {:string, :generic}}],
      response: [{204, :map}, {400, :null}, {401, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get is watching issue bulk

  Returns, for the user, details of the watched status of issues from a list. If an issue ID is invalid, the returned watched status is `false`.

  This operation requires the **Allow users to watch issues** option to be *ON*. This option is set in General configuration for Jira. See [Configuring Jira application options](https://confluence.atlassian.com/x/uYXKM) for details.

  **[Permissions](#permissions) required:**

   *  *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project that the issue is in
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is configured, issue-level security permission to view the issue.
  """
  @spec get_is_watching_issue_bulk(Jirex.IssueList.t(), keyword) ::
          {:ok, Jirex.BulkIssueIsWatching.t()} | :error
  def get_is_watching_issue_bulk(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jirex.IssueWatchers, :get_is_watching_issue_bulk},
      url: "/rest/api/2/issue/watching",
      body: body,
      method: :post,
      request: [{"application/json", {Jirex.IssueList, :t}}],
      response: [{200, {Jirex.BulkIssueIsWatching, :t}}, {401, :null}],
      opts: opts
    })
  end

  @doc """
  Get issue watchers

  Returns the watchers for an issue.

  This operation requires the **Allow users to watch issues** option to be *ON*. This option is set in General configuration for Jira. See [Configuring Jira application options](https://confluence.atlassian.com/x/uYXKM) for details.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:**

   *  *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project that the issue is ini
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is configured, issue-level security permission to view the issue.
   *  To see details of users on the watchlist other than themselves, *View voters and watchers* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project that the issue is in.
  """
  @spec get_issue_watchers(String.t(), keyword) :: {:ok, Jirex.Watchers.t()} | :error
  def get_issue_watchers(issueIdOrKey, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [issueIdOrKey: issueIdOrKey],
      call: {Jirex.IssueWatchers, :get_issue_watchers},
      url: "/rest/api/2/issue/#{issueIdOrKey}/watchers",
      method: :get,
      response: [{200, {Jirex.Watchers, :t}}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Delete watcher

  Deletes a user as a watcher of an issue.

  This operation requires the **Allow users to watch issues** option to be *ON*. This option is set in General configuration for Jira. See [Configuring Jira application options](https://confluence.atlassian.com/x/uYXKM) for details.

  **[Permissions](#permissions) required:**

   *  *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project that the issue is in.
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is configured, issue-level security permission to view the issue.
   *  To remove users other than themselves from the watchlist, *Manage watcher list* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project that the issue is in.

  ## Options

    * `username`: This parameter is no longer available. See the [deprecation notice](https://developer.atlassian.com/cloud/jira/platform/deprecation-notice-user-privacy-api-migration-guide/) for details.
    * `accountId`: The account ID of the user, which uniquely identifies the user across all Atlassian products. For example, *5b10ac8d82e05b22cc7d4ef5*. Required.

  """
  @spec remove_watcher(String.t(), keyword) :: :ok | :error
  def remove_watcher(issueIdOrKey, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:accountId, :username])

    client.request(%{
      args: [issueIdOrKey: issueIdOrKey],
      call: {Jirex.IssueWatchers, :remove_watcher},
      url: "/rest/api/2/issue/#{issueIdOrKey}/watchers",
      method: :delete,
      query: query,
      response: [{204, :null}, {400, :null}, {401, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end
end
