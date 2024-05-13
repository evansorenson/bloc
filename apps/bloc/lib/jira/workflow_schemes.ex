defmodule Jira.WorkflowSchemes do
  @moduledoc """
  Provides API endpoints related to workflow schemes
  """

  @default_client Jira.Client

  @doc """
  Create workflow scheme

  Creates a workflow scheme.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec create_workflow_scheme(Jira.WorkflowScheme.t(), keyword) ::
          {:ok, Jira.WorkflowScheme.t()} | :error
  def create_workflow_scheme(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jira.WorkflowSchemes, :create_workflow_scheme},
      url: "/rest/api/2/workflowscheme",
      body: body,
      method: :post,
      request: [{"application/json", {Jira.WorkflowScheme, :t}}],
      response: [{201, {Jira.WorkflowScheme, :t}}, {400, :null}, {401, :null}, {403, :null}],
      opts: opts
    })
  end

  @doc """
  Delete default workflow

  Resets the default workflow for a workflow scheme. That is, the default workflow is set to Jira's system workflow (the *jira* workflow).

  Note that active workflow schemes cannot be edited. If the workflow scheme is active, set `updateDraftIfNeeded` to `true` and a draft workflow scheme is created or updated with the default workflow reset. The draft workflow scheme can be published in Jira.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `updateDraftIfNeeded`: Set to true to create or update the draft of a workflow scheme and delete the mapping from the draft, when the workflow scheme cannot be edited. Defaults to `false`.

  """
  @spec delete_default_workflow(integer, keyword) :: {:ok, Jira.WorkflowScheme.t()} | :error
  def delete_default_workflow(id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:updateDraftIfNeeded])

    client.request(%{
      args: [id: id],
      call: {Jira.WorkflowSchemes, :delete_default_workflow},
      url: "/rest/api/2/workflowscheme/#{id}/default",
      method: :delete,
      query: query,
      response: [
        {200, {Jira.WorkflowScheme, :t}},
        {400, :null},
        {401, :null},
        {403, :null},
        {404, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Delete issue types for workflow in workflow scheme

  Deletes the workflow-issue type mapping for a workflow in a workflow scheme.

  Note that active workflow schemes cannot be edited. If the workflow scheme is active, set `updateDraftIfNeeded` to `true` and a draft workflow scheme is created or updated with the workflow-issue type mapping deleted. The draft workflow scheme can be published in Jira.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `workflowName`: The name of the workflow.
    * `updateDraftIfNeeded`: Set to true to create or update the draft of a workflow scheme and delete the mapping from the draft, when the workflow scheme cannot be edited. Defaults to `false`.

  """
  @spec delete_workflow_mapping(integer, keyword) :: :ok | :error
  def delete_workflow_mapping(id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:updateDraftIfNeeded, :workflowName])

    client.request(%{
      args: [id: id],
      call: {Jira.WorkflowSchemes, :delete_workflow_mapping},
      url: "/rest/api/2/workflowscheme/#{id}/workflow",
      method: :delete,
      query: query,
      response: [{200, :null}, {400, :null}, {401, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Delete workflow scheme

  Deletes a workflow scheme. Note that a workflow scheme cannot be deleted if it is active (that is, being used by at least one project).

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec delete_workflow_scheme(integer, keyword) :: {:ok, map} | :error
  def delete_workflow_scheme(id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id],
      call: {Jira.WorkflowSchemes, :delete_workflow_scheme},
      url: "/rest/api/2/workflowscheme/#{id}",
      method: :delete,
      response: [{204, :map}, {400, :null}, {401, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Delete workflow for issue type in workflow scheme

  Deletes the issue type-workflow mapping for an issue type in a workflow scheme.

  Note that active workflow schemes cannot be edited. If the workflow scheme is active, set `updateDraftIfNeeded` to `true` and a draft workflow scheme is created or updated with the issue type-workflow mapping deleted. The draft workflow scheme can be published in Jira.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `updateDraftIfNeeded`: Set to true to create or update the draft of a workflow scheme and update the mapping in the draft, when the workflow scheme cannot be edited. Defaults to `false`.

  """
  @spec delete_workflow_scheme_issue_type(integer, String.t(), keyword) ::
          {:ok, Jira.WorkflowScheme.t()} | :error
  def delete_workflow_scheme_issue_type(id, issueType, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:updateDraftIfNeeded])

    client.request(%{
      args: [id: id, issueType: issueType],
      call: {Jira.WorkflowSchemes, :delete_workflow_scheme_issue_type},
      url: "/rest/api/2/workflowscheme/#{id}/issuetype/#{issueType}",
      method: :delete,
      query: query,
      response: [
        {200, {Jira.WorkflowScheme, :t}},
        {400, :null},
        {401, :null},
        {403, :null},
        {404, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Get all workflow schemes

  Returns a [paginated](#pagination) list of all workflow schemes, not including draft workflow schemes.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.

  """
  @spec get_all_workflow_schemes(keyword) :: {:ok, Jira.PageBeanWorkflowScheme.t()} | :error
  def get_all_workflow_schemes(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:maxResults, :startAt])

    client.request(%{
      args: [],
      call: {Jira.WorkflowSchemes, :get_all_workflow_schemes},
      url: "/rest/api/2/workflowscheme",
      method: :get,
      query: query,
      response: [{200, {Jira.PageBeanWorkflowScheme, :t}}, {401, :null}, {403, :null}],
      opts: opts
    })
  end

  @doc """
  Get default workflow

  Returns the default workflow for a workflow scheme. The default workflow is the workflow that is assigned any issue types that have not been mapped to any other workflow. The default workflow has *All Unassigned Issue Types* listed in its issue types for the workflow scheme in Jira.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `returnDraftIfExists`: Set to `true` to return the default workflow for the workflow scheme's draft rather than scheme itself. If the workflow scheme does not have a draft, then the default workflow for the workflow scheme is returned.

  """
  @spec get_default_workflow(integer, keyword) :: {:ok, Jira.DefaultWorkflow.t()} | :error
  def get_default_workflow(id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:returnDraftIfExists])

    client.request(%{
      args: [id: id],
      call: {Jira.WorkflowSchemes, :get_default_workflow},
      url: "/rest/api/2/workflowscheme/#{id}/default",
      method: :get,
      query: query,
      response: [{200, {Jira.DefaultWorkflow, :t}}, {401, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get issue types for workflows in workflow scheme

  Returns the workflow-issue type mappings for a workflow scheme.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `workflowName`: The name of a workflow in the scheme. Limits the results to the workflow-issue type mapping for the specified workflow.
    * `returnDraftIfExists`: Returns the mapping from the workflow scheme's draft rather than the workflow scheme, if set to true. If no draft exists, the mapping from the workflow scheme is returned.

  """
  @spec get_workflow(integer, keyword) :: {:ok, Jira.IssueTypesWorkflowMapping.t()} | :error
  def get_workflow(id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:returnDraftIfExists, :workflowName])

    client.request(%{
      args: [id: id],
      call: {Jira.WorkflowSchemes, :get_workflow},
      url: "/rest/api/2/workflowscheme/#{id}/workflow",
      method: :get,
      query: query,
      response: [
        {200, {Jira.IssueTypesWorkflowMapping, :t}},
        {401, :null},
        {403, :null},
        {404, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Get workflow scheme

  Returns a workflow scheme.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `returnDraftIfExists`: Returns the workflow scheme's draft rather than scheme itself, if set to true. If the workflow scheme does not have a draft, then the workflow scheme is returned.

  """
  @spec get_workflow_scheme(integer, keyword) :: {:ok, Jira.WorkflowScheme.t()} | :error
  def get_workflow_scheme(id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:returnDraftIfExists])

    client.request(%{
      args: [id: id],
      call: {Jira.WorkflowSchemes, :get_workflow_scheme},
      url: "/rest/api/2/workflowscheme/#{id}",
      method: :get,
      query: query,
      response: [{200, {Jira.WorkflowScheme, :t}}, {401, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get workflow for issue type in workflow scheme

  Returns the issue type-workflow mapping for an issue type in a workflow scheme.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `returnDraftIfExists`: Returns the mapping from the workflow scheme's draft rather than the workflow scheme, if set to true. If no draft exists, the mapping from the workflow scheme is returned.

  """
  @spec get_workflow_scheme_issue_type(integer, String.t(), keyword) ::
          {:ok, Jira.IssueTypeWorkflowMapping.t()} | :error
  def get_workflow_scheme_issue_type(id, issueType, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:returnDraftIfExists])

    client.request(%{
      args: [id: id, issueType: issueType],
      call: {Jira.WorkflowSchemes, :get_workflow_scheme_issue_type},
      url: "/rest/api/2/workflowscheme/#{id}/issuetype/#{issueType}",
      method: :get,
      query: query,
      response: [
        {200, {Jira.IssueTypeWorkflowMapping, :t}},
        {401, :null},
        {403, :null},
        {404, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Bulk get workflow schemes

  Returns a list of workflow schemes by providing workflow scheme IDs or project IDs.

  **[Permissions](#permissions) required:**

   *  *Administer Jira* global permission to access all, including project-scoped, workflow schemes
   *  *Administer projects* project permissions to access project-scoped workflow schemes

  ## Options

    * `expand`: Use [expand](#expansion) to include additional information in the response. This parameter accepts a comma-separated list. Expand options include:
      
       *  `workflows.usages` Returns the project and issue types that each workflow in the workflow scheme is associated with.

  """
  @spec read_workflow_schemes(Jira.WorkflowSchemeReadRequest.t(), keyword) ::
          {:ok, [Jira.WorkflowSchemeReadResponse.t()]} | :error
  def read_workflow_schemes(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:expand])

    client.request(%{
      args: [body: body],
      call: {Jira.WorkflowSchemes, :read_workflow_schemes},
      url: "/rest/api/2/workflowscheme/read",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Jira.WorkflowSchemeReadRequest, :t}}],
      response: [{200, [{Jira.WorkflowSchemeReadResponse, :t}]}, {400, :null}, {401, :null}],
      opts: opts
    })
  end

  @doc """
  Set workflow for issue type in workflow scheme

  Sets the workflow for an issue type in a workflow scheme.

  Note that active workflow schemes cannot be edited. If the workflow scheme is active, set `updateDraftIfNeeded` to `true` in the request body and a draft workflow scheme is created or updated with the new issue type-workflow mapping. The draft workflow scheme can be published in Jira.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec set_workflow_scheme_issue_type(
          integer,
          String.t(),
          Jira.IssueTypeWorkflowMapping.t(),
          keyword
        ) :: {:ok, Jira.WorkflowScheme.t()} | :error
  def set_workflow_scheme_issue_type(id, issueType, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id, issueType: issueType, body: body],
      call: {Jira.WorkflowSchemes, :set_workflow_scheme_issue_type},
      url: "/rest/api/2/workflowscheme/#{id}/issuetype/#{issueType}",
      body: body,
      method: :put,
      request: [{"application/json", {Jira.IssueTypeWorkflowMapping, :t}}],
      response: [
        {200, {Jira.WorkflowScheme, :t}},
        {400, :null},
        {401, :null},
        {403, :null},
        {404, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Update default workflow

  Sets the default workflow for a workflow scheme.

  Note that active workflow schemes cannot be edited. If the workflow scheme is active, set `updateDraftIfNeeded` to `true` in the request object and a draft workflow scheme is created or updated with the new default workflow. The draft workflow scheme can be published in Jira.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec update_default_workflow(integer, Jira.DefaultWorkflow.t(), keyword) ::
          {:ok, Jira.WorkflowScheme.t()} | :error
  def update_default_workflow(id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id, body: body],
      call: {Jira.WorkflowSchemes, :update_default_workflow},
      url: "/rest/api/2/workflowscheme/#{id}/default",
      body: body,
      method: :put,
      request: [{"application/json", {Jira.DefaultWorkflow, :t}}],
      response: [
        {200, {Jira.WorkflowScheme, :t}},
        {400, :null},
        {401, :null},
        {403, :null},
        {404, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Update workflow scheme

  Updates company-managed and team-managed project workflow schemes. This API doesn't have a concept of draft, so any changes made to a workflow scheme are immediately available. When changing the available statuses for issue types, an [asynchronous task](#async) migrates the issues as defined in the provided mappings.

  **[Permissions](#permissions) required:**

   *  *Administer Jira* project permission to update all, including global-scoped, workflow schemes.
   *  *Administer projects* project permission to update project-scoped workflow schemes.
  """
  @spec update_schemes(Jira.WorkflowSchemeUpdateRequest.t(), keyword) :: {:ok, map} | :error
  def update_schemes(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jira.WorkflowSchemes, :update_schemes},
      url: "/rest/api/2/workflowscheme/update",
      body: body,
      method: :post,
      request: [{"application/json", {Jira.WorkflowSchemeUpdateRequest, :t}}],
      response: [
        {200, :map},
        {303, {Jira.TaskProgressBeanObject, :t}},
        {400, :null},
        {401, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Set issue types for workflow in workflow scheme

  Sets the issue types for a workflow in a workflow scheme. The workflow can also be set as the default workflow for the workflow scheme. Unmapped issues types are mapped to the default workflow.

  Note that active workflow schemes cannot be edited. If the workflow scheme is active, set `updateDraftIfNeeded` to `true` in the request body and a draft workflow scheme is created or updated with the new workflow-issue types mappings. The draft workflow scheme can be published in Jira.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `workflowName`: The name of the workflow.

  """
  @spec update_workflow_mapping(integer, Jira.IssueTypesWorkflowMapping.t(), keyword) ::
          {:ok, Jira.WorkflowScheme.t()} | :error
  def update_workflow_mapping(id, body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:workflowName])

    client.request(%{
      args: [id: id, body: body],
      call: {Jira.WorkflowSchemes, :update_workflow_mapping},
      url: "/rest/api/2/workflowscheme/#{id}/workflow",
      body: body,
      method: :put,
      query: query,
      request: [{"application/json", {Jira.IssueTypesWorkflowMapping, :t}}],
      response: [
        {200, {Jira.WorkflowScheme, :t}},
        {400, :null},
        {401, :null},
        {403, :null},
        {404, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Classic update workflow scheme

  Updates a company-manged project workflow scheme, including the name, default workflow, issue type to project mappings, and more. If the workflow scheme is active (that is, being used by at least one project), then a draft workflow scheme is created or updated instead, provided that `updateDraftIfNeeded` is set to `true`.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec update_workflow_scheme(integer, Jira.WorkflowScheme.t(), keyword) ::
          {:ok, Jira.WorkflowScheme.t()} | :error
  def update_workflow_scheme(id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id, body: body],
      call: {Jira.WorkflowSchemes, :update_workflow_scheme},
      url: "/rest/api/2/workflowscheme/#{id}",
      body: body,
      method: :put,
      request: [{"application/json", {Jira.WorkflowScheme, :t}}],
      response: [
        {200, {Jira.WorkflowScheme, :t}},
        {400, :null},
        {401, :null},
        {403, :null},
        {404, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Get required status mappings for workflow scheme update

  Gets the required status mappings for the desired changes to a workflow scheme. The results are provided per issue type and workflow. When updating a workflow scheme, status mappings can be provided per issue type, per workflow, or both.

  **[Permissions](#permissions) required:**

   *  *Administer Jira* permission to update all, including global-scoped, workflow schemes.
   *  *Administer projects* project permission to update project-scoped workflow schemes.
  """
  @spec update_workflow_scheme_mappings(
          Jira.WorkflowSchemeUpdateRequiredMappingsRequest.t(),
          keyword
        ) :: {:ok, Jira.WorkflowSchemeUpdateRequiredMappingsResponse.t()} | :error
  def update_workflow_scheme_mappings(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jira.WorkflowSchemes, :update_workflow_scheme_mappings},
      url: "/rest/api/2/workflowscheme/update/mappings",
      body: body,
      method: :post,
      request: [{"application/json", {Jira.WorkflowSchemeUpdateRequiredMappingsRequest, :t}}],
      response: [
        {200, {Jira.WorkflowSchemeUpdateRequiredMappingsResponse, :t}},
        {400, :null},
        {401, :null}
      ],
      opts: opts
    })
  end
end
