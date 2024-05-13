defmodule Jira.WorkflowStatusCategories do
  @moduledoc """
  Provides API endpoints related to workflow status categories
  """

  @default_client Jira.Client

  @doc """
  Get all status categories

  Returns a list of all status categories.

  **[Permissions](#permissions) required:** Permission to access Jira.
  """
  @spec get_status_categories(keyword) :: {:ok, [Jira.StatusCategory.t()]} | :error
  def get_status_categories(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Jira.WorkflowStatusCategories, :get_status_categories},
      url: "/rest/api/2/statuscategory",
      method: :get,
      response: [{200, [{Jira.StatusCategory, :t}]}, {401, :null}],
      opts: opts
    })
  end

  @doc """
  Get status category

  Returns a status category. Status categories provided a mechanism for categorizing [statuses](#api-rest-api-2-status-idOrName-get).

  **[Permissions](#permissions) required:** Permission to access Jira.
  """
  @spec get_status_category(String.t(), keyword) :: {:ok, Jira.StatusCategory.t()} | :error
  def get_status_category(idOrKey, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [idOrKey: idOrKey],
      call: {Jira.WorkflowStatusCategories, :get_status_category},
      url: "/rest/api/2/statuscategory/#{idOrKey}",
      method: :get,
      response: [{200, {Jira.StatusCategory, :t}}, {401, :null}, {404, :null}],
      opts: opts
    })
  end
end
