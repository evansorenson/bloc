defmodule Jira.WorkflowSchemeDrafts do
  @moduledoc """
  Provides API endpoints related to workflow scheme drafts
  """

  @default_client Jira.Client

  @doc """
  Create draft workflow scheme

  Create a draft workflow scheme from an active workflow scheme, by copying the active workflow scheme. Note that an active workflow scheme can only have one draft workflow scheme.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec create_workflow_scheme_draft_from_parent(integer, keyword) ::
          {:ok, Jira.WorkflowScheme.t()} | :error
  def create_workflow_scheme_draft_from_parent(id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id],
      call: {Jira.WorkflowSchemeDrafts, :create_workflow_scheme_draft_from_parent},
      url: "/rest/api/2/workflowscheme/#{id}/createdraft",
      method: :post,
      response: [{201, {Jira.WorkflowScheme, :t}}, {400, :null}, {401, :null}, {403, :null}],
      opts: opts
    })
  end

  @doc """
  Delete draft default workflow

  Resets the default workflow for a workflow scheme's draft. That is, the default workflow is set to Jira's system workflow (the *jira* workflow).

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec delete_draft_default_workflow(integer, keyword) :: {:ok, Jira.WorkflowScheme.t()} | :error
  def delete_draft_default_workflow(id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id],
      call: {Jira.WorkflowSchemeDrafts, :delete_draft_default_workflow},
      url: "/rest/api/2/workflowscheme/#{id}/draft/default",
      method: :delete,
      response: [{200, {Jira.WorkflowScheme, :t}}, {401, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Delete issue types for workflow in draft workflow scheme

  Deletes the workflow-issue type mapping for a workflow in a workflow scheme's draft.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `workflowName`: The name of the workflow.

  """
  @spec delete_draft_workflow_mapping(integer, keyword) :: :ok | :error
  def delete_draft_workflow_mapping(id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:workflowName])

    client.request(%{
      args: [id: id],
      call: {Jira.WorkflowSchemeDrafts, :delete_draft_workflow_mapping},
      url: "/rest/api/2/workflowscheme/#{id}/draft/workflow",
      method: :delete,
      query: query,
      response: [{200, :null}, {401, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Delete draft workflow scheme

  Deletes a draft workflow scheme.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec delete_workflow_scheme_draft(integer, keyword) :: :ok | :error
  def delete_workflow_scheme_draft(id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id],
      call: {Jira.WorkflowSchemeDrafts, :delete_workflow_scheme_draft},
      url: "/rest/api/2/workflowscheme/#{id}/draft",
      method: :delete,
      response: [{204, :null}, {401, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Delete workflow for issue type in draft workflow scheme

  Deletes the issue type-workflow mapping for an issue type in a workflow scheme's draft.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec delete_workflow_scheme_draft_issue_type(integer, String.t(), keyword) ::
          {:ok, Jira.WorkflowScheme.t()} | :error
  def delete_workflow_scheme_draft_issue_type(id, issueType, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id, issueType: issueType],
      call: {Jira.WorkflowSchemeDrafts, :delete_workflow_scheme_draft_issue_type},
      url: "/rest/api/2/workflowscheme/#{id}/draft/issuetype/#{issueType}",
      method: :delete,
      response: [{200, {Jira.WorkflowScheme, :t}}, {401, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get draft default workflow

  Returns the default workflow for a workflow scheme's draft. The default workflow is the workflow that is assigned any issue types that have not been mapped to any other workflow. The default workflow has *All Unassigned Issue Types* listed in its issue types for the workflow scheme in Jira.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec get_draft_default_workflow(integer, keyword) :: {:ok, Jira.DefaultWorkflow.t()} | :error
  def get_draft_default_workflow(id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id],
      call: {Jira.WorkflowSchemeDrafts, :get_draft_default_workflow},
      url: "/rest/api/2/workflowscheme/#{id}/draft/default",
      method: :get,
      response: [{200, {Jira.DefaultWorkflow, :t}}, {401, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get issue types for workflows in draft workflow scheme

  Returns the workflow-issue type mappings for a workflow scheme's draft.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `workflowName`: The name of a workflow in the scheme. Limits the results to the workflow-issue type mapping for the specified workflow.

  """
  @spec get_draft_workflow(integer, keyword) :: {:ok, Jira.IssueTypesWorkflowMapping.t()} | :error
  def get_draft_workflow(id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:workflowName])

    client.request(%{
      args: [id: id],
      call: {Jira.WorkflowSchemeDrafts, :get_draft_workflow},
      url: "/rest/api/2/workflowscheme/#{id}/draft/workflow",
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
  Get draft workflow scheme

  Returns the draft workflow scheme for an active workflow scheme. Draft workflow schemes allow changes to be made to the active workflow schemes: When an active workflow scheme is updated, a draft copy is created. The draft is modified, then the changes in the draft are copied back to the active workflow scheme. See [Configuring workflow schemes](https://confluence.atlassian.com/x/tohKLg) for more information.  
  Note that:

   *  Only active workflow schemes can have draft workflow schemes.
   *  An active workflow scheme can only have one draft workflow scheme.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec get_workflow_scheme_draft(integer, keyword) :: {:ok, Jira.WorkflowScheme.t()} | :error
  def get_workflow_scheme_draft(id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id],
      call: {Jira.WorkflowSchemeDrafts, :get_workflow_scheme_draft},
      url: "/rest/api/2/workflowscheme/#{id}/draft",
      method: :get,
      response: [{200, {Jira.WorkflowScheme, :t}}, {401, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get workflow for issue type in draft workflow scheme

  Returns the issue type-workflow mapping for an issue type in a workflow scheme's draft.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec get_workflow_scheme_draft_issue_type(integer, String.t(), keyword) ::
          {:ok, Jira.IssueTypeWorkflowMapping.t()} | :error
  def get_workflow_scheme_draft_issue_type(id, issueType, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id, issueType: issueType],
      call: {Jira.WorkflowSchemeDrafts, :get_workflow_scheme_draft_issue_type},
      url: "/rest/api/2/workflowscheme/#{id}/draft/issuetype/#{issueType}",
      method: :get,
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
  Publish draft workflow scheme

  Publishes a draft workflow scheme.

  Where the draft workflow includes new workflow statuses for an issue type, mappings are provided to update issues with the original workflow status to the new workflow status.

  This operation is [asynchronous](#async). Follow the `location` link in the response to determine the status of the task and use [Get task](#api-rest-api-2-task-taskId-get) to obtain updates.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `validateOnly`: Whether the request only performs a validation.

  """
  @spec publish_draft_workflow_scheme(integer, Jira.PublishDraftWorkflowScheme.t(), keyword) ::
          :ok | {:error, any}
  def publish_draft_workflow_scheme(id, body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:validateOnly])

    client.request(%{
      args: [id: id, body: body],
      call: {Jira.WorkflowSchemeDrafts, :publish_draft_workflow_scheme},
      url: "/rest/api/2/workflowscheme/#{id}/draft/publish",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Jira.PublishDraftWorkflowScheme, :t}}],
      response: [
        {204, :null},
        {303, {Jira.TaskProgressBeanObject, :t}},
        {400, :unknown},
        {401, :null},
        {403, :null},
        {404, :unknown}
      ],
      opts: opts
    })
  end

  @doc """
  Set workflow for issue type in draft workflow scheme

  Sets the workflow for an issue type in a workflow scheme's draft.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec set_workflow_scheme_draft_issue_type(
          integer,
          String.t(),
          Jira.IssueTypeWorkflowMapping.t(),
          keyword
        ) :: {:ok, Jira.WorkflowScheme.t()} | :error
  def set_workflow_scheme_draft_issue_type(id, issueType, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id, issueType: issueType, body: body],
      call: {Jira.WorkflowSchemeDrafts, :set_workflow_scheme_draft_issue_type},
      url: "/rest/api/2/workflowscheme/#{id}/draft/issuetype/#{issueType}",
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
  Update draft default workflow

  Sets the default workflow for a workflow scheme's draft.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec update_draft_default_workflow(integer, Jira.DefaultWorkflow.t(), keyword) ::
          {:ok, Jira.WorkflowScheme.t()} | :error
  def update_draft_default_workflow(id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id, body: body],
      call: {Jira.WorkflowSchemeDrafts, :update_draft_default_workflow},
      url: "/rest/api/2/workflowscheme/#{id}/draft/default",
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
  Set issue types for workflow in workflow scheme

  Sets the issue types for a workflow in a workflow scheme's draft. The workflow can also be set as the default workflow for the draft workflow scheme. Unmapped issues types are mapped to the default workflow.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `workflowName`: The name of the workflow.

  """
  @spec update_draft_workflow_mapping(integer, Jira.IssueTypesWorkflowMapping.t(), keyword) ::
          {:ok, Jira.WorkflowScheme.t()} | :error
  def update_draft_workflow_mapping(id, body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:workflowName])

    client.request(%{
      args: [id: id, body: body],
      call: {Jira.WorkflowSchemeDrafts, :update_draft_workflow_mapping},
      url: "/rest/api/2/workflowscheme/#{id}/draft/workflow",
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
  Update draft workflow scheme

  Updates a draft workflow scheme. If a draft workflow scheme does not exist for the active workflow scheme, then a draft is created. Note that an active workflow scheme can only have one draft workflow scheme.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec update_workflow_scheme_draft(integer, Jira.WorkflowScheme.t(), keyword) ::
          {:ok, Jira.WorkflowScheme.t()} | :error
  def update_workflow_scheme_draft(id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id, body: body],
      call: {Jira.WorkflowSchemeDrafts, :update_workflow_scheme_draft},
      url: "/rest/api/2/workflowscheme/#{id}/draft",
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
end
