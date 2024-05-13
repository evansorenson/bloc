defmodule Jira.WorkflowStatuses do
  @moduledoc """
  Provides API endpoints related to workflow statuses
  """

  @default_client Jira.Client

  @doc """
  Get status

  Returns a status. The status must be associated with an active workflow to be returned.

  If a name is used on more than one status, only the status found first is returned. Therefore, identifying the status by its ID may be preferable.

  This operation can be accessed anonymously.

  [Permissions](#permissions) required: None.
  """
  @spec get_status(String.t(), keyword) :: {:ok, Jira.StatusDetails.t()} | :error
  def get_status(idOrName, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [idOrName: idOrName],
      call: {Jira.WorkflowStatuses, :get_status},
      url: "/rest/api/2/status/#{idOrName}",
      method: :get,
      response: [{200, {Jira.StatusDetails, :t}}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get all statuses

  Returns a list of all statuses associated with active workflows.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** None.
  """
  @spec get_statuses(keyword) :: {:ok, [Jira.StatusDetails.t()]} | :error
  def get_statuses(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Jira.WorkflowStatuses, :get_statuses},
      url: "/rest/api/2/status",
      method: :get,
      response: [{200, [{Jira.StatusDetails, :t}]}, {401, :null}],
      opts: opts
    })
  end
end
