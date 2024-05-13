defmodule Jira.IssueWorklogs do
  @moduledoc """
  Provides API endpoints related to issue worklogs
  """

  @default_client Jira.Client

  @doc """
  Add worklog

  Adds a worklog to an issue.

  Time tracking must be enabled in Jira, otherwise this operation returns an error. For more information, see [Configuring time tracking](https://confluence.atlassian.com/x/qoXKM).

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:**

   *  *Browse projects* and *Work on issues* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project that the issue is in.
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is configured, issue-level security permission to view the issue.

  ## Options

    * `notifyUsers`: Whether users watching the issue are notified by email.
    * `adjustEstimate`: Defines how to update the issue's time estimate, the options are:
      
       *  `new` Sets the estimate to a specific value, defined in `newEstimate`.
       *  `leave` Leaves the estimate unchanged.
       *  `manual` Reduces the estimate by amount specified in `reduceBy`.
       *  `auto` Reduces the estimate by the value of `timeSpent` in the worklog.
    * `newEstimate`: The value to set as the issue's remaining time estimate, as days (\#d), hours (\#h), or minutes (\#m or \#). For example, *2d*. Required when `adjustEstimate` is `new`.
    * `reduceBy`: The amount to reduce the issue's remaining estimate by, as days (\#d), hours (\#h), or minutes (\#m). For example, *2d*. Required when `adjustEstimate` is `manual`.
    * `expand`: Use [expand](#expansion) to include additional information about work logs in the response. This parameter accepts `properties`, which returns worklog properties.
    * `overrideEditableFlag`: Whether the worklog entry should be added to the issue even if the issue is not editable, because jira.issue.editable set to false or missing. For example, the issue is closed. Connect and Forge app users with *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg) can use this flag.

  """
  @spec add_worklog(String.t(), Jira.Worklog.t(), keyword) :: {:ok, Jira.Worklog.t()} | :error
  def add_worklog(issueIdOrKey, body, opts \\ []) do
    client = opts[:client] || @default_client

    query =
      Keyword.take(opts, [
        :adjustEstimate,
        :expand,
        :newEstimate,
        :notifyUsers,
        :overrideEditableFlag,
        :reduceBy
      ])

    client.request(%{
      args: [issueIdOrKey: issueIdOrKey, body: body],
      call: {Jira.IssueWorklogs, :add_worklog},
      url: "/rest/api/2/issue/#{issueIdOrKey}/worklog",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Jira.Worklog, :t}}],
      response: [
        {201, {Jira.Worklog, :t}},
        {400, :null},
        {401, :null},
        {404, :null},
        {413, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Delete worklog

  Deletes a worklog from an issue.

  Time tracking must be enabled in Jira, otherwise this operation returns an error. For more information, see [Configuring time tracking](https://confluence.atlassian.com/x/qoXKM).

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:**

   *  *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project that the issue is in.
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is configured, issue-level security permission to view the issue.
   *  *Delete all worklogs*[ project permission](https://confluence.atlassian.com/x/yodKLg) to delete any worklog or *Delete own worklogs* to delete worklogs created by the user,
   *  If the worklog has visibility restrictions, belongs to the group or has the role visibility is restricted to.

  ## Options

    * `notifyUsers`: Whether users watching the issue are notified by email.
    * `adjustEstimate`: Defines how to update the issue's time estimate, the options are:
      
       *  `new` Sets the estimate to a specific value, defined in `newEstimate`.
       *  `leave` Leaves the estimate unchanged.
       *  `manual` Increases the estimate by amount specified in `increaseBy`.
       *  `auto` Reduces the estimate by the value of `timeSpent` in the worklog.
    * `newEstimate`: The value to set as the issue's remaining time estimate, as days (\#d), hours (\#h), or minutes (\#m or \#). For example, *2d*. Required when `adjustEstimate` is `new`.
    * `increaseBy`: The amount to increase the issue's remaining estimate by, as days (\#d), hours (\#h), or minutes (\#m or \#). For example, *2d*. Required when `adjustEstimate` is `manual`.
    * `overrideEditableFlag`: Whether the work log entry should be added to the issue even if the issue is not editable, because jira.issue.editable set to false or missing. For example, the issue is closed. Connect and Forge app users with admin permission can use this flag.

  """
  @spec delete_worklog(String.t(), String.t(), keyword) :: :ok | :error
  def delete_worklog(issueIdOrKey, id, opts \\ []) do
    client = opts[:client] || @default_client

    query =
      Keyword.take(opts, [
        :adjustEstimate,
        :increaseBy,
        :newEstimate,
        :notifyUsers,
        :overrideEditableFlag
      ])

    client.request(%{
      args: [issueIdOrKey: issueIdOrKey, id: id],
      call: {Jira.IssueWorklogs, :delete_worklog},
      url: "/rest/api/2/issue/#{issueIdOrKey}/worklog/#{id}",
      method: :delete,
      query: query,
      response: [{204, :null}, {400, :null}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get IDs of deleted worklogs

  Returns a list of IDs and delete timestamps for worklogs deleted after a date and time.

  This resource is paginated, with a limit of 1000 worklogs per page. Each page lists worklogs from oldest to youngest. If the number of items in the date range exceeds 1000, `until` indicates the timestamp of the youngest item on the page. Also, `nextPage` provides the URL for the next page of worklogs. The `lastPage` parameter is set to true on the last page of worklogs.

  This resource does not return worklogs deleted during the minute preceding the request.

  **[Permissions](#permissions) required:** Permission to access Jira.

  ## Options

    * `since`: The date and time, as a UNIX timestamp in milliseconds, after which deleted worklogs are returned.

  """
  @spec get_ids_of_worklogs_deleted_since(keyword) :: {:ok, Jira.ChangedWorklogs.t()} | :error
  def get_ids_of_worklogs_deleted_since(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:since])

    client.request(%{
      args: [],
      call: {Jira.IssueWorklogs, :get_ids_of_worklogs_deleted_since},
      url: "/rest/api/2/worklog/deleted",
      method: :get,
      query: query,
      response: [{200, {Jira.ChangedWorklogs, :t}}, {401, :null}],
      opts: opts
    })
  end

  @doc """
  Get IDs of updated worklogs

  Returns a list of IDs and update timestamps for worklogs updated after a date and time.

  This resource is paginated, with a limit of 1000 worklogs per page. Each page lists worklogs from oldest to youngest. If the number of items in the date range exceeds 1000, `until` indicates the timestamp of the youngest item on the page. Also, `nextPage` provides the URL for the next page of worklogs. The `lastPage` parameter is set to true on the last page of worklogs.

  This resource does not return worklogs updated during the minute preceding the request.

  **[Permissions](#permissions) required:** Permission to access Jira, however, worklogs are only returned where either of the following is true:

   *  the worklog is set as *Viewable by All Users*.
   *  the user is a member of a project role or group with permission to view the worklog.

  ## Options

    * `since`: The date and time, as a UNIX timestamp in milliseconds, after which updated worklogs are returned.
    * `expand`: Use [expand](#expansion) to include additional information about worklogs in the response. This parameter accepts `properties` that returns the properties of each worklog.

  """
  @spec get_ids_of_worklogs_modified_since(keyword) :: {:ok, Jira.ChangedWorklogs.t()} | :error
  def get_ids_of_worklogs_modified_since(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:expand, :since])

    client.request(%{
      args: [],
      call: {Jira.IssueWorklogs, :get_ids_of_worklogs_modified_since},
      url: "/rest/api/2/worklog/updated",
      method: :get,
      query: query,
      response: [{200, {Jira.ChangedWorklogs, :t}}, {401, :null}],
      opts: opts
    })
  end

  @doc """
  Get issue worklogs

  Returns worklogs for an issue, starting from the oldest worklog or from the worklog started on or after a date and time.

  Time tracking must be enabled in Jira, otherwise this operation returns an error. For more information, see [Configuring time tracking](https://confluence.atlassian.com/x/qoXKM).

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** Workloads are only returned where the user has:

   *  *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project that the issue is in.
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is configured, issue-level security permission to view the issue.
   *  If the worklog has visibility restrictions, belongs to the group or has the role visibility is restricted to.

  ## Options

    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.
    * `startedAfter`: The worklog start date and time, as a UNIX timestamp in milliseconds, after which worklogs are returned.
    * `startedBefore`: The worklog start date and time, as a UNIX timestamp in milliseconds, before which worklogs are returned.
    * `expand`: Use [expand](#expansion) to include additional information about worklogs in the response. This parameter accepts`properties`, which returns worklog properties.

  """
  @spec get_issue_worklog(String.t(), keyword) :: {:ok, Jira.PageOfWorklogs.t()} | :error
  def get_issue_worklog(issueIdOrKey, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:expand, :maxResults, :startAt, :startedAfter, :startedBefore])

    client.request(%{
      args: [issueIdOrKey: issueIdOrKey],
      call: {Jira.IssueWorklogs, :get_issue_worklog},
      url: "/rest/api/2/issue/#{issueIdOrKey}/worklog",
      method: :get,
      query: query,
      response: [{200, {Jira.PageOfWorklogs, :t}}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get worklog

  Returns a worklog.

  Time tracking must be enabled in Jira, otherwise this operation returns an error. For more information, see [Configuring time tracking](https://confluence.atlassian.com/x/qoXKM).

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:**

   *  *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project that the issue is in.
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is configured, issue-level security permission to view the issue.
   *  If the worklog has visibility restrictions, belongs to the group or has the role visibility is restricted to.

  ## Options

    * `expand`: Use [expand](#expansion) to include additional information about work logs in the response. This parameter accepts
      
      `properties`, which returns worklog properties.

  """
  @spec get_worklog(String.t(), String.t(), keyword) :: {:ok, Jira.Worklog.t()} | :error
  def get_worklog(issueIdOrKey, id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:expand])

    client.request(%{
      args: [issueIdOrKey: issueIdOrKey, id: id],
      call: {Jira.IssueWorklogs, :get_worklog},
      url: "/rest/api/2/issue/#{issueIdOrKey}/worklog/#{id}",
      method: :get,
      query: query,
      response: [{200, {Jira.Worklog, :t}}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get worklogs

  Returns worklog details for a list of worklog IDs.

  The returned list of worklogs is limited to 1000 items.

  **[Permissions](#permissions) required:** Permission to access Jira, however, worklogs are only returned where either of the following is true:

   *  the worklog is set as *Viewable by All Users*.
   *  the user is a member of a project role or group with permission to view the worklog.

  ## Options

    * `expand`: Use [expand](#expansion) to include additional information about worklogs in the response. This parameter accepts `properties` that returns the properties of each worklog.

  """
  @spec get_worklogs_for_ids(Jira.WorklogIdsRequestBean.t(), keyword) ::
          {:ok, [Jira.Worklog.t()]} | :error
  def get_worklogs_for_ids(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:expand])

    client.request(%{
      args: [body: body],
      call: {Jira.IssueWorklogs, :get_worklogs_for_ids},
      url: "/rest/api/2/worklog/list",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Jira.WorklogIdsRequestBean, :t}}],
      response: [{200, [{Jira.Worklog, :t}]}, {400, :null}, {401, :null}],
      opts: opts
    })
  end

  @doc """
  Update worklog

  Updates a worklog.

  Time tracking must be enabled in Jira, otherwise this operation returns an error. For more information, see [Configuring time tracking](https://confluence.atlassian.com/x/qoXKM).

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:**

   *  *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project that the issue is in.
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is configured, issue-level security permission to view the issue.
   *  *Edit all worklogs*[ project permission](https://confluence.atlassian.com/x/yodKLg) to update any worklog or *Edit own worklogs* to update worklogs created by the user.
   *  If the worklog has visibility restrictions, belongs to the group or has the role visibility is restricted to.

  ## Options

    * `notifyUsers`: Whether users watching the issue are notified by email.
    * `adjustEstimate`: Defines how to update the issue's time estimate, the options are:
      
       *  `new` Sets the estimate to a specific value, defined in `newEstimate`.
       *  `leave` Leaves the estimate unchanged.
       *  `auto` Updates the estimate by the difference between the original and updated value of `timeSpent` or `timeSpentSeconds`.
    * `newEstimate`: The value to set as the issue's remaining time estimate, as days (\#d), hours (\#h), or minutes (\#m or \#). For example, *2d*. Required when `adjustEstimate` is `new`.
    * `expand`: Use [expand](#expansion) to include additional information about worklogs in the response. This parameter accepts `properties`, which returns worklog properties.
    * `overrideEditableFlag`: Whether the worklog should be added to the issue even if the issue is not editable. For example, because the issue is closed. Connect and Forge app users with *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg) can use this flag.

  """
  @spec update_worklog(String.t(), String.t(), Jira.Worklog.t(), keyword) ::
          {:ok, Jira.Worklog.t()} | :error
  def update_worklog(issueIdOrKey, id, body, opts \\ []) do
    client = opts[:client] || @default_client

    query =
      Keyword.take(opts, [
        :adjustEstimate,
        :expand,
        :newEstimate,
        :notifyUsers,
        :overrideEditableFlag
      ])

    client.request(%{
      args: [issueIdOrKey: issueIdOrKey, id: id, body: body],
      call: {Jira.IssueWorklogs, :update_worklog},
      url: "/rest/api/2/issue/#{issueIdOrKey}/worklog/#{id}",
      body: body,
      method: :put,
      query: query,
      request: [{"application/json", {Jira.Worklog, :t}}],
      response: [{200, {Jira.Worklog, :t}}, {400, :null}, {401, :null}, {404, :null}],
      opts: opts
    })
  end
end
