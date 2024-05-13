defmodule Jira.AppDataPolicies do
  @moduledoc """
  Provides API endpoints related to app data policies
  """

  @default_client Jira.Client

  @doc """
  Get data policy for projects

  Returns data policies for the projects specified in the request.

  ## Options

    * `ids`: A list of project identifiers. This parameter accepts a comma-separated list.

  """
  @spec get_policies(keyword) ::
          {:ok, Jira.ProjectDataPolicies.t()} | {:error, Jira.ErrorCollection.t()}
  def get_policies(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:ids])

    client.request(%{
      args: [],
      call: {Jira.AppDataPolicies, :get_policies},
      url: "/rest/api/2/data-policy/project",
      method: :get,
      query: query,
      response: [
        {200, {Jira.ProjectDataPolicies, :t}},
        {400, {Jira.ErrorCollection, :t}},
        {401, {Jira.ErrorCollection, :t}},
        {403, {Jira.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get data policy for the workspace

  Returns data policy for the workspace.
  """
  @spec get_policy(keyword) ::
          {:ok, Jira.WorkspaceDataPolicy.t()} | {:error, Jira.ErrorCollection.t()}
  def get_policy(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Jira.AppDataPolicies, :get_policy},
      url: "/rest/api/2/data-policy",
      method: :get,
      response: [
        {200, {Jira.WorkspaceDataPolicy, :t}},
        {401, {Jira.ErrorCollection, :t}},
        {403, {Jira.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end
end
