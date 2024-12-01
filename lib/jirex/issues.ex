defmodule Jirex.Issues do
  @moduledoc """
  Provides API endpoints related to issues
  """

  @default_client Jirex.Client

  @doc """
  Archive issue(s) by issue ID/key

  Enables admins to archive up to 1000 issues in a single request using issue ID/key, returning details of the issue(s) archived in the process and the errors encountered, if any.

  **Note that:**

   *  you can't archive subtasks directly, only through their parent issues
   *  you can only archive issues from software, service management, and business projects

  **[Permissions](#permissions) required:** Jira admin or site admin: [global permission](https://confluence.atlassian.com/x/x4dKLg)

  **License required:** Premium or Enterprise

  **Signed-in users only:** This API can't be accessed anonymously.



  """
  @spec archive_issues(Jirex.IssueArchivalSyncRequest.t(), keyword) ::
          {:ok, Jirex.IssueArchivalSyncResponse.t()} | {:error, any}
  def archive_issues(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jirex.Issues, :archive_issues},
      url: "/rest/api/2/issue/archive",
      body: body,
      method: :put,
      request: [{"application/json", {Jirex.IssueArchivalSyncRequest, :t}}],
      response: [
        {200, {Jirex.IssueArchivalSyncResponse, :t}},
        {400, :unknown},
        {401, :unknown},
        {403, :unknown},
        {412, :unknown}
      ],
      opts: opts
    })
  end

  @doc """
  Archive issue(s) by JQL

  Enables admins to archive up to 100,000 issues in a single request using JQL, returning the URL to check the status of the submitted request.

  You can use the [get task](https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-tasks/#api-rest-api-3-task-taskid-get) and [cancel task](https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-tasks/#api-rest-api-3-task-taskid-cancel-post) APIs to manage the request.

  **Note that:**

   *  you can't archive subtasks directly, only through their parent issues
   *  you can only archive issues from software, service management, and business projects

  **[Permissions](#permissions) required:** Jira admin or site admin: [global permission](https://confluence.atlassian.com/x/x4dKLg)

  **License required:** Premium or Enterprise

  **Signed-in users only:** This API can't be accessed anonymously.

  **Rate limiting:** Only a single request per jira instance can be active at any given time.



  """
  @spec archive_issues_async(Jirex.ArchiveIssueAsyncRequest.t(), keyword) ::
          {:ok, String.t()} | {:error, any}
  def archive_issues_async(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jirex.Issues, :archive_issues_async},
      url: "/rest/api/2/issue/archive",
      body: body,
      method: :post,
      request: [{"application/json", {Jirex.ArchiveIssueAsyncRequest, :t}}],
      response: [
        {202, {:string, :generic}},
        {400, :unknown},
        {401, :unknown},
        {403, :unknown},
        {412, :unknown}
      ],
      opts: opts
    })
  end

  @doc """
  Assign issue

  Assigns an issue to a user. Use this operation when the calling user does not have the *Edit Issues* permission but has the *Assign issue* permission for the project that the issue is in.

  If `name` or `accountId` is set to:

   *  `"-1"`, the issue is assigned to the default assignee for the project.
   *  `null`, the issue is set to unassigned.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:**

   *  *Browse Projects* and *Assign Issues* [ project permission](https://confluence.atlassian.com/x/yodKLg) for the project that the issue is in.
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is configured, issue-level security permission to view the issue.
  """
  @spec assign_issue(String.t(), Jirex.User.t(), keyword) :: {:ok, map} | :error
  def assign_issue(issueIdOrKey, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [issueIdOrKey: issueIdOrKey, body: body],
      call: {Jirex.Issues, :assign_issue},
      url: "/rest/api/2/issue/#{issueIdOrKey}/assignee",
      body: body,
      method: :put,
      request: [{"application/json", {Jirex.User, :t}}],
      response: [{204, :map}, {400, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Create issue

  Creates an issue or, where the option to create subtasks is enabled in Jira, a subtask. A transition may be applied, to move the issue or subtask to a workflow step other than the default start step, and issue properties set.

  The content of the issue or subtask is defined using `update` and `fields`. The fields that can be set in the issue or subtask are determined using the [ Get create issue metadata](#api-rest-api-2-issue-createmeta-get). These are the same fields that appear on the issue's create screen.

  Creating a subtask differs from creating an issue as follows:

   *  `issueType` must be set to a subtask issue type (use [ Get create issue metadata](#api-rest-api-2-issue-createmeta-get) to find subtask issue types).
   *  `parent` must contain the ID or key of the parent issue.

  **[Permissions](#permissions) required:** *Browse projects* and *Create issues* [project permissions](https://confluence.atlassian.com/x/yodKLg) for the project in which the issue or subtask is created.

  ## Options

    * `updateHistory`: Whether the project in which the issue is created is added to the user's **Recently viewed** project list, as shown under **Projects** in Jira. When provided, the issue type and request type are added to the user's history for a project. These values are then used to provide defaults on the issue create screen.

  """
  @spec create_issue(Jirex.IssueUpdateDetails.t(), keyword) ::
          {:ok, Jirex.CreatedIssue.t()} | {:error, Jirex.ErrorCollection.t()}
  def create_issue(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:updateHistory])

    client.request(%{
      args: [body: body],
      call: {Jirex.Issues, :create_issue},
      url: "/rest/api/2/issue",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Jirex.IssueUpdateDetails, :t}}],
      response: [
        {201, {Jirex.CreatedIssue, :t}},
        {400, {Jirex.ErrorCollection, :t}},
        {401, {Jirex.ErrorCollection, :t}},
        {403, {Jirex.ErrorCollection, :t}},
        {422, {Jirex.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Bulk create issue

  Creates upto **50** issues and, where the option to create subtasks is enabled in Jira, subtasks. Transitions may be applied, to move the issues or subtasks to a workflow step other than the default start step, and issue properties set.

  The content of each issue or subtask is defined using `update` and `fields`. The fields that can be set in the issue or subtask are determined using the [ Get create issue metadata](#api-rest-api-2-issue-createmeta-get). These are the same fields that appear on the issues' create screens.

  Creating a subtask differs from creating an issue as follows:

   *  `issueType` must be set to a subtask issue type (use [ Get create issue metadata](#api-rest-api-2-issue-createmeta-get) to find subtask issue types).
   *  `parent` the must contain the ID or key of the parent issue.

  **[Permissions](#permissions) required:** *Browse projects* and *Create issues* [project permissions](https://confluence.atlassian.com/x/yodKLg) for the project in which each issue or subtask is created.
  """
  @spec create_issues(Jirex.IssuesUpdateBean.t(), keyword) ::
          {:ok, Jirex.CreatedIssues.t()} | {:error, Jirex.CreatedIssues.t()}
  def create_issues(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jirex.Issues, :create_issues},
      url: "/rest/api/2/issue/bulk",
      body: body,
      method: :post,
      request: [{"application/json", {Jirex.IssuesUpdateBean, :t}}],
      response: [{201, {Jirex.CreatedIssues, :t}}, {400, {Jirex.CreatedIssues, :t}}, {401, :null}],
      opts: opts
    })
  end

  @doc """
  Delete issue

  Deletes an issue.

  An issue cannot be deleted if it has one or more subtasks. To delete an issue with subtasks, set `deleteSubtasks`. This causes the issue's subtasks to be deleted with the issue.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:**

   *  *Browse projects* and *Delete issues* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project containing the issue.
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is configured, issue-level security permission to view the issue.

  ## Options

    * `deleteSubtasks`: Whether the issue's subtasks are deleted when the issue is deleted.

  """
  @spec delete_issue(String.t(), keyword) :: :ok | :error
  def delete_issue(issueIdOrKey, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:deleteSubtasks])

    client.request(%{
      args: [issueIdOrKey: issueIdOrKey],
      call: {Jirex.Issues, :delete_issue},
      url: "/rest/api/2/issue/#{issueIdOrKey}",
      method: :delete,
      query: query,
      response: [{204, :null}, {400, :null}, {401, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Transition issue

  Performs an issue transition and, if the transition has a screen, updates the fields from the transition screen.

  sortByCategory To update the fields on the transition screen, specify the fields in the `fields` or `update` parameters in the request body. Get details about the fields using [ Get transitions](#api-rest-api-2-issue-issueIdOrKey-transitions-get) with the `transitions.fields` expand.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:**

   *  *Browse projects* and *Transition issues* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project that the issue is in.
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is configured, issue-level security permission to view the issue.
  """
  @spec do_transition(String.t(), Jirex.IssueUpdateDetails.t(), keyword) :: {:ok, map} | :error
  def do_transition(issueIdOrKey, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [issueIdOrKey: issueIdOrKey, body: body],
      call: {Jirex.Issues, :do_transition},
      url: "/rest/api/2/issue/#{issueIdOrKey}/transitions",
      body: body,
      method: :post,
      request: [{"application/json", {Jirex.IssueUpdateDetails, :t}}],
      response: [
        {204, :map},
        {400, :null},
        {401, :null},
        {404, :null},
        {409, :null},
        {413, :null},
        {422, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Edit issue

  Edits an issue. Issue properties may be updated as part of the edit. Please note that issue transition will be ignored as it is not supported yet.

  The edits to the issue's fields are defined using `update` and `fields`. The fields that can be edited are determined using [ Get edit issue metadata](#api-rest-api-2-issue-issueIdOrKey-editmeta-get).

  The parent field may be set by key or ID. For standard issue types, the parent may be removed by setting `update.parent.set.none` to *true*.

  Connect apps having an app user with *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg), and Forge apps acting on behalf of users with *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg), can override the screen security configuration using `overrideScreenSecurity` and `overrideEditableFlag`.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:**

   *  *Browse projects* and *Edit issues* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project that the issue is in.
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is configured, issue-level security permission to view the issue.

  ## Options

    * `notifyUsers`: Whether a notification email about the issue update is sent to all watchers. To disable the notification, administer Jira or administer project permissions are required. If the user doesn't have the necessary permission the request is ignored.
    * `overrideScreenSecurity`: Whether screen security is overridden to enable hidden fields to be edited. Available to Connect app users with *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg) and Forge apps acting on behalf of users with *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
    * `overrideEditableFlag`: Whether screen security is overridden to enable uneditable fields to be edited. Available to Connect app users with *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg) and Forge apps acting on behalf of users with *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
    * `returnIssue`: Whether the response should contain the issue with fields edited in this request. The returned issue will have the same format as in the [Get issue API](#api-rest-api-3-issue-issueidorkey-get).
    * `expand`: The Get issue API expand parameter to use in the response if the `returnIssue` parameter is `true`.

  """
  @spec edit_issue(String.t(), Jirex.IssueUpdateDetails.t(), keyword) :: {:ok, map} | :error
  def edit_issue(issueIdOrKey, body, opts \\ []) do
    client = opts[:client] || @default_client

    query =
      Keyword.take(opts, [
        :expand,
        :notifyUsers,
        :overrideEditableFlag,
        :overrideScreenSecurity,
        :returnIssue
      ])

    client.request(%{
      args: [issueIdOrKey: issueIdOrKey, body: body],
      call: {Jirex.Issues, :edit_issue},
      url: "/rest/api/2/issue/#{issueIdOrKey}",
      body: body,
      method: :put,
      query: query,
      request: [{"application/json", {Jirex.IssueUpdateDetails, :t}}],
      response: [
        {200, :map},
        {204, :map},
        {400, :null},
        {401, :null},
        {403, :null},
        {404, :null},
        {409, :null},
        {422, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Export archived issue(s)

  Enables admins to retrieve details of all archived issues. Upon a successful request, the admin who submitted it will receive an email with a link to download a CSV file with the issue details.

  Note that this API only exports the values of system fields and archival-specific fields (`ArchivedBy` and `ArchivedDate`). Custom fields aren't supported.

  **[Permissions](#permissions) required:** Jira admin or site admin: [global permission](https://confluence.atlassian.com/x/x4dKLg)

  **License required:** Premium or Enterprise

  **Signed-in users only:** This API can't be accessed anonymously.

  **Rate limiting:** Only a single request can be active at any given time.



  """
  @spec export_archived_issues(Jirex.ArchivedIssuesFilterRequest.t(), keyword) ::
          {:ok, Jirex.ExportArchivedIssuesTaskProgressResponse.t()} | {:error, any}
  def export_archived_issues(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jirex.Issues, :export_archived_issues},
      url: "/rest/api/2/issues/archive/export",
      body: body,
      method: :put,
      request: [{"application/json", {Jirex.ArchivedIssuesFilterRequest, :t}}],
      response: [
        {202, {Jirex.ExportArchivedIssuesTaskProgressResponse, :t}},
        {400, :unknown},
        {401, :unknown},
        {403, :unknown},
        {412, :unknown}
      ],
      opts: opts
    })
  end

  @doc """
  Get changelogs

  Returns a [paginated](#pagination) list of all changelogs for an issue sorted by date, starting from the oldest.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:**

   *  *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project that the issue is in.
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is configured, issue-level security permission to view the issue.

  ## Options

    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.

  """
  @spec get_change_logs(String.t(), keyword) :: {:ok, Jirex.PageBeanChangelog.t()} | :error
  def get_change_logs(issueIdOrKey, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:maxResults, :startAt])

    client.request(%{
      args: [issueIdOrKey: issueIdOrKey],
      call: {Jirex.Issues, :get_change_logs},
      url: "/rest/api/2/issue/#{issueIdOrKey}/changelog",
      method: :get,
      query: query,
      response: [{200, {Jirex.PageBeanChangelog, :t}}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get changelogs by IDs

  Returns changelogs for an issue specified by a list of changelog IDs.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:**

   *  *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project that the issue is in.
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is configured, issue-level security permission to view the issue.
  """
  @spec get_change_logs_by_ids(String.t(), Jirex.IssueChangelogIds.t(), keyword) ::
          {:ok, Jirex.PageOfChangelogs.t()} | :error
  def get_change_logs_by_ids(issueIdOrKey, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [issueIdOrKey: issueIdOrKey, body: body],
      call: {Jirex.Issues, :get_change_logs_by_ids},
      url: "/rest/api/2/issue/#{issueIdOrKey}/changelog/list",
      body: body,
      method: :post,
      request: [{"application/json", {Jirex.IssueChangelogIds, :t}}],
      response: [{200, {Jirex.PageOfChangelogs, :t}}, {400, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get create issue metadata

  Returns details of projects, issue types within projects, and, when requested, the create screen fields for each issue type for the user. Use the information to populate the requests in [ Create issue](#api-rest-api-2-issue-post) and [Create issues](#api-rest-api-2-issue-bulk-post).

  Deprecated, see [Create Issue Meta Endpoint Deprecation Notice](https://developer.atlassian.com/cloud/jira/platform/changelog/#CHANGE-1304).

  The request can be restricted to specific projects or issue types using the query parameters. The response will contain information for the valid projects, issue types, or project and issue type combinations requested. Note that invalid project, issue type, or project and issue type combinations do not generate errors.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** *Create issues* [project permission](https://confluence.atlassian.com/x/yodKLg) in the requested projects.

  ## Options

    * `projectIds`: List of project IDs. This parameter accepts a comma-separated list. Multiple project IDs can also be provided using an ampersand-separated list. For example, `projectIds=10000,10001&projectIds=10020,10021`. This parameter may be provided with `projectKeys`.
    * `projectKeys`: List of project keys. This parameter accepts a comma-separated list. Multiple project keys can also be provided using an ampersand-separated list. For example, `projectKeys=proj1,proj2&projectKeys=proj3`. This parameter may be provided with `projectIds`.
    * `issuetypeIds`: List of issue type IDs. This parameter accepts a comma-separated list. Multiple issue type IDs can also be provided using an ampersand-separated list. For example, `issuetypeIds=10000,10001&issuetypeIds=10020,10021`. This parameter may be provided with `issuetypeNames`.
    * `issuetypeNames`: List of issue type names. This parameter accepts a comma-separated list. Multiple issue type names can also be provided using an ampersand-separated list. For example, `issuetypeNames=name1,name2&issuetypeNames=name3`. This parameter may be provided with `issuetypeIds`.
    * `expand`: Use [expand](#expansion) to include additional information about issue metadata in the response. This parameter accepts `projects.issuetypes.fields`, which returns information about the fields in the issue creation screen for each issue type. Fields hidden from the screen are not returned. Use the information to populate the `fields` and `update` fields in [Create issue](#api-rest-api-2-issue-post) and [Create issues](#api-rest-api-2-issue-bulk-post).

  """
  @spec get_create_issue_meta(keyword) :: {:ok, Jirex.IssueCreateMetadata.t()} | :error
  def get_create_issue_meta(opts \\ []) do
    client = opts[:client] || @default_client

    query =
      Keyword.take(opts, [:expand, :issuetypeIds, :issuetypeNames, :projectIds, :projectKeys])

    client.request(%{
      args: [],
      call: {Jirex.Issues, :get_create_issue_meta},
      url: "/rest/api/2/issue/createmeta",
      method: :get,
      query: query,
      response: [{200, {Jirex.IssueCreateMetadata, :t}}, {401, :null}],
      opts: opts
    })
  end

  @doc """
  Get create field metadata for a project and issue type id

  Returns a page of field metadata for a specified project and issuetype id. Use the information to populate the requests in [ Create issue](#api-rest-api-2-issue-post) and [Create issues](#api-rest-api-2-issue-bulk-post).

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** *Create issues* [project permission](https://confluence.atlassian.com/x/yodKLg) in the requested projects.

  ## Options

    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.

  """
  @spec get_create_issue_meta_issue_type_id(String.t(), String.t(), keyword) ::
          {:ok, Jirex.PageOfCreateMetaIssueTypeWithField.t()} | {:error, any}
  def get_create_issue_meta_issue_type_id(projectIdOrKey, issueTypeId, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:maxResults, :startAt])

    client.request(%{
      args: [projectIdOrKey: projectIdOrKey, issueTypeId: issueTypeId],
      call: {Jirex.Issues, :get_create_issue_meta_issue_type_id},
      url: "/rest/api/2/issue/createmeta/#{projectIdOrKey}/issuetypes/#{issueTypeId}",
      method: :get,
      query: query,
      response: [
        {200, {Jirex.PageOfCreateMetaIssueTypeWithField, :t}},
        {400, :unknown},
        {401, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Get create metadata issue types for a project

  Returns a page of issue type metadata for a specified project. Use the information to populate the requests in [ Create issue](#api-rest-api-2-issue-post) and [Create issues](#api-rest-api-2-issue-bulk-post).

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** *Create issues* [project permission](https://confluence.atlassian.com/x/yodKLg) in the requested projects.

  ## Options

    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.

  """
  @spec get_create_issue_meta_issue_types(String.t(), keyword) ::
          {:ok, Jirex.PageOfCreateMetaIssueTypes.t()} | {:error, any}
  def get_create_issue_meta_issue_types(projectIdOrKey, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:maxResults, :startAt])

    client.request(%{
      args: [projectIdOrKey: projectIdOrKey],
      call: {Jirex.Issues, :get_create_issue_meta_issue_types},
      url: "/rest/api/2/issue/createmeta/#{projectIdOrKey}/issuetypes",
      method: :get,
      query: query,
      response: [{200, {Jirex.PageOfCreateMetaIssueTypes, :t}}, {400, :unknown}, {401, :null}],
      opts: opts
    })
  end

  @doc """
  Get edit issue metadata

  Returns the edit screen fields for an issue that are visible to and editable by the user. Use the information to populate the requests in [Edit issue](#api-rest-api-2-issue-issueIdOrKey-put).

  This endpoint will check for these conditions:

  1.  Field is available on a field screen - through screen, screen scheme, issue type screen scheme, and issue type scheme configuration. `overrideScreenSecurity=true` skips this condition.
  2.  Field is visible in the [field configuration](https://support.atlassian.com/jira-cloud-administration/docs/change-a-field-configuration/). `overrideScreenSecurity=true` skips this condition.
  3.  Field is shown on the issue: each field has different conditions here. For example: Attachment field only shows if attachments are enabled. Assignee only shows if user has permissions to assign the issue.
  4.  If a field is custom then it must have valid custom field context, applicable for its project and issue type. All system fields are assumed to have context in all projects and all issue types.
  5.  Issue has a project, issue type, and status defined.
  6.  Issue is assigned to a valid workflow, and the current status has assigned a workflow step. `overrideEditableFlag=true` skips this condition.
  7.  The current workflow step is editable. This is true by default, but [can be disabled by setting](https://support.atlassian.com/jira-cloud-administration/docs/use-workflow-properties/) the `jira.issue.editable` property to `false`. `overrideEditableFlag=true` skips this condition.
  8.  User has [Edit issues permission](https://support.atlassian.com/jira-cloud-administration/docs/permissions-for-company-managed-projects/).
  9.  Workflow permissions allow editing a field. This is true by default but [can be modified](https://support.atlassian.com/jira-cloud-administration/docs/use-workflow-properties/) using `jira.permission.*` workflow properties.

  Fields hidden using [Issue layout settings page](https://support.atlassian.com/jira-software-cloud/docs/configure-field-layout-in-the-issue-view/) remain editable.

  Connect apps having an app user with *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg), and Forge apps acting on behalf of users with *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg), can return additional details using:

   *  `overrideScreenSecurity` When this flag is `true`, then this endpoint skips checking if fields are available through screens, and field configuration (conditions 1. and 2. from the list above).
   *  `overrideEditableFlag` When this flag is `true`, then this endpoint skips checking if workflow is present and if the current step is editable (conditions 6. and 7. from the list above).

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:**

   *  *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project that the issue is in.
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is configured, issue-level security permission to view the issue.

  Note: For any fields to be editable the user must have the *Edit issues* [project permission](https://confluence.atlassian.com/x/yodKLg) for the issue.

  ## Options

    * `overrideScreenSecurity`: Whether hidden fields are returned. Available to Connect app users with *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg) and Forge apps acting on behalf of users with *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
    * `overrideEditableFlag`: Whether non-editable fields are returned. Available to Connect app users with *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg) and Forge apps acting on behalf of users with *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  """
  @spec get_edit_issue_meta(String.t(), keyword) :: {:ok, Jirex.IssueUpdateMetadata.t()} | :error
  def get_edit_issue_meta(issueIdOrKey, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:overrideEditableFlag, :overrideScreenSecurity])

    client.request(%{
      args: [issueIdOrKey: issueIdOrKey],
      call: {Jirex.Issues, :get_edit_issue_meta},
      url: "/rest/api/2/issue/#{issueIdOrKey}/editmeta",
      method: :get,
      query: query,
      response: [{200, {Jirex.IssueUpdateMetadata, :t}}, {401, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get events

  Returns all issue events.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec get_events(keyword) :: {:ok, [Jirex.IssueEvent.t()]} | :error
  def get_events(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Jirex.Issues, :get_events},
      url: "/rest/api/2/events",
      method: :get,
      response: [{200, [{Jirex.IssueEvent, :t}]}, {401, :null}, {403, :null}],
      opts: opts
    })
  end

  @doc """
  Get issue

  Returns the details for an issue.

  The issue is identified by its ID or key, however, if the identifier doesn't match an issue, a case-insensitive search and check for moved issues is performed. If a matching issue is found its details are returned, a 302 or other redirect is **not** returned. The issue key returned in the response is the key of the issue found.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:**

   *  *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project that the issue is in.
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is configured, issue-level security permission to view the issue.

  ## Options

    * `fields`: A list of fields to return for the issue. This parameter accepts a comma-separated list. Use it to retrieve a subset of fields. Allowed values:

       *  `*all` Returns all fields.
       *  `*navigable` Returns navigable fields.
       *  Any issue field, prefixed with a minus to exclude.

      Examples:

       *  `summary,comment` Returns only the summary and comments fields.
       *  `-description` Returns all (default) fields except description.
       *  `*navigable,-comment` Returns all navigable fields except comment.

      This parameter may be specified multiple times. For example, `fields=field1,field2& fields=field3`.

      Note: All fields are returned by default. This differs from [Search for issues using JQL (GET)](#api-rest-api-2-search-get) and [Search for issues using JQL (POST)](#api-rest-api-2-search-post) where the default is all navigable fields.
    * `fieldsByKeys`: Whether fields in `fields` are referenced by keys rather than IDs. This parameter is useful where fields have been added by a connect app and a field's key may differ from its ID.
    * `expand`: Use [expand](#expansion) to include additional information about the issues in the response. This parameter accepts a comma-separated list. Expand options include:

       *  `renderedFields` Returns field values rendered in HTML format.
       *  `names` Returns the display name of each field.
       *  `schema` Returns the schema describing a field type.
       *  `transitions` Returns all possible transitions for the issue.
       *  `editmeta` Returns information about how each field can be edited.
       *  `changelog` Returns a list of recent updates to an issue, sorted by date, starting from the most recent.
       *  `versionedRepresentations` Returns a JSON array for each version of a field's value, with the highest number representing the most recent version. Note: When included in the request, the `fields` parameter is ignored.
    * `properties`: A list of issue properties to return for the issue. This parameter accepts a comma-separated list. Allowed values:

       *  `*all` Returns all issue properties.
       *  Any issue property key, prefixed with a minus to exclude.

      Examples:

       *  `*all` Returns all properties.
       *  `*all,-prop1` Returns all properties except `prop1`.
       *  `prop1,prop2` Returns `prop1` and `prop2` properties.

      This parameter may be specified multiple times. For example, `properties=prop1,prop2& properties=prop3`.
    * `updateHistory`: Whether the project in which the issue is created is added to the user's **Recently viewed** project list, as shown under **Projects** in Jira. This also populates the [JQL issues search](#api-rest-api-2-search-get) `lastViewed` field.

  """
  @spec get_issue(String.t(), keyword) :: {:ok, Jirex.IssueBean.t()} | :error
  def get_issue(issueIdOrKey, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:expand, :fields, :fieldsByKeys, :properties, :updateHistory])

    client.request(%{
      args: [issueIdOrKey: issueIdOrKey],
      call: {Jirex.Issues, :get_issue},
      url: "/rest/api/2/issue/#{issueIdOrKey}",
      method: :get,
      query: query,
      response: [{200, {Jirex.IssueBean, :t}}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get issue limit report

  Returns all issues breaching and approaching per-issue limits.

  **[Permissions](#permissions) required:**

   *  *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) is required for the project the issues are in. Results may be incomplete otherwise
   *  *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec get_issue_limit_report(Jirex.IssueLimitReportRequest.t(), keyword) ::
          {:ok, Jirex.IssueLimitReportResponseBean.t()} | :error
  def get_issue_limit_report(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jirex.Issues, :get_issue_limit_report},
      url: "/rest/api/2/issue/limit/report",
      body: body,
      method: :get,
      request: [{"application/json", {Jirex.IssueLimitReportRequest, :t}}],
      response: [
        {200, {Jirex.IssueLimitReportResponseBean, :t}},
        {400, :null},
        {401, :null},
        {403, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Get transitions

  Returns either all transitions or a transition that can be performed by the user on an issue, based on the issue's status.

  Note, if a request is made for a transition that does not exist or cannot be performed on the issue, given its status, the response will return any empty transitions list.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required: A list or transition is returned only when the user has:**

   *  *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project that the issue is in.
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is configured, issue-level security permission to view the issue.

  However, if the user does not have the *Transition issues* [ project permission](https://confluence.atlassian.com/x/yodKLg) the response will not list any transitions.

  ## Options

    * `expand`: Use [expand](#expansion) to include additional information about transitions in the response. This parameter accepts `transitions.fields`, which returns information about the fields in the transition screen for each transition. Fields hidden from the screen are not returned. Use this information to populate the `fields` and `update` fields in [Transition issue](#api-rest-api-2-issue-issueIdOrKey-transitions-post).
    * `transitionId`: The ID of the transition.
    * `skipRemoteOnlyCondition`: Whether transitions with the condition *Hide From User Condition* are included in the response.
    * `includeUnavailableTransitions`: Whether details of transitions that fail a condition are included in the response
    * `sortByOpsBarAndStatus`: Whether the transitions are sorted by ops-bar sequence value first then category order (Todo, In Progress, Done) or only by ops-bar sequence value.

  """
  @spec get_transitions(String.t(), keyword) :: {:ok, Jirex.Transitions.t()} | :error
  def get_transitions(issueIdOrKey, opts \\ []) do
    client = opts[:client] || @default_client

    query =
      Keyword.take(opts, [
        :expand,
        :includeUnavailableTransitions,
        :skipRemoteOnlyCondition,
        :sortByOpsBarAndStatus,
        :transitionId
      ])

    client.request(%{
      args: [issueIdOrKey: issueIdOrKey],
      call: {Jirex.Issues, :get_transitions},
      url: "/rest/api/2/issue/#{issueIdOrKey}/transitions",
      method: :get,
      query: query,
      response: [{200, {Jirex.Transitions, :t}}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Send notification for issue

  Creates an email notification for an issue and adds it to the mail queue.

  **[Permissions](#permissions) required:**

   *  *Browse Projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project that the issue is in.
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is configured, issue-level security permission to view the issue.
  """
  @spec notify(String.t(), Jirex.Notification.t(), keyword) :: {:ok, map} | :error
  def notify(issueIdOrKey, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [issueIdOrKey: issueIdOrKey, body: body],
      call: {Jirex.Issues, :notify},
      url: "/rest/api/2/issue/#{issueIdOrKey}/notify",
      body: body,
      method: :post,
      request: [{"application/json", {Jirex.Notification, :t}}],
      response: [{204, :map}, {400, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Unarchive issue(s) by issue keys/ID

  Enables admins to unarchive up to 1000 issues in a single request using issue ID/key, returning details of the issue(s) unarchived in the process and the errors encountered, if any.

  **Note that:**

   *  you can't unarchive subtasks directly, only through their parent issues
   *  you can only unarchive issues from software, service management, and business projects

  **[Permissions](#permissions) required:** Jira admin or site admin: [global permission](https://confluence.atlassian.com/x/x4dKLg)

  **License required:** Premium or Enterprise

  **Signed-in users only:** This API can't be accessed anonymously.



  """
  @spec unarchive_issues(Jirex.IssueArchivalSyncRequest.t(), keyword) ::
          {:ok, Jirex.IssueArchivalSyncResponse.t()} | {:error, any}
  def unarchive_issues(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jirex.Issues, :unarchive_issues},
      url: "/rest/api/2/issue/unarchive",
      body: body,
      method: :put,
      request: [{"application/json", {Jirex.IssueArchivalSyncRequest, :t}}],
      response: [
        {200, {Jirex.IssueArchivalSyncResponse, :t}},
        {400, :unknown},
        {401, :unknown},
        {403, :unknown},
        {412, :unknown}
      ],
      opts: opts
    })
  end
end
