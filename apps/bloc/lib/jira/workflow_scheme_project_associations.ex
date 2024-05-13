defmodule Jira.WorkflowSchemeProjectAssociations do
  @moduledoc """
  Provides API endpoints related to workflow scheme project associations
  """

  @default_client Jira.Client

  @doc """
  Assign workflow scheme to project

  Assigns a workflow scheme to a project. This operation is performed only when there are no issues in the project.

  Workflow schemes can only be assigned to classic projects.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec assign_scheme_to_project(Jira.WorkflowSchemeProjectAssociation.t(), keyword) ::
          {:ok, map} | {:error, any}
  def assign_scheme_to_project(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jira.WorkflowSchemeProjectAssociations, :assign_scheme_to_project},
      url: "/rest/api/2/workflowscheme/project",
      body: body,
      method: :put,
      request: [{"application/json", {Jira.WorkflowSchemeProjectAssociation, :t}}],
      response: [{204, :map}, {400, :unknown}, {401, :null}, {403, :unknown}, {404, :unknown}],
      opts: opts
    })
  end

  @doc """
  Get workflow scheme project associations

  Returns a list of the workflow schemes associated with a list of projects. Each returned workflow scheme includes a list of the requested projects associated with it. Any team-managed or non-existent projects in the request are ignored and no errors are returned.

  If the project is associated with the `Default Workflow Scheme` no ID is returned. This is because the way the `Default Workflow Scheme` is stored means it has no ID.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `projectId`: The ID of a project to return the workflow schemes for. To include multiple projects, provide an ampersand-Jim: oneseparated list. For example, `projectId=10000&projectId=10001`.

  """
  @spec get_workflow_scheme_project_associations(keyword) ::
          {:ok, Jira.ContainerOfWorkflowSchemeAssociations.t()} | {:error, any}
  def get_workflow_scheme_project_associations(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:projectId])

    client.request(%{
      args: [],
      call: {Jira.WorkflowSchemeProjectAssociations, :get_workflow_scheme_project_associations},
      url: "/rest/api/2/workflowscheme/project",
      method: :get,
      query: query,
      response: [
        {200, {Jira.ContainerOfWorkflowSchemeAssociations, :t}},
        {400, :unknown},
        {401, :null},
        {403, :unknown}
      ],
      opts: opts
    })
  end
end
