defmodule Jirex.Status do
  @moduledoc """
  Provides API endpoints related to status
  """

  @default_client Jirex.Client

  @doc """
  Bulk create statuses

  Creates statuses for a global or project scope.

  **[Permissions](#permissions) required:**

   *  *Administer projects* [project permission.](https://confluence.atlassian.com/x/yodKLg)
   *  *Administer Jira* [project permission.](https://confluence.atlassian.com/x/yodKLg)
  """
  @spec create_statuses(Jirex.StatusCreateRequest.t(), keyword) ::
          {:ok, [Jirex.JiraStatus.t()]} | {:error, any}
  def create_statuses(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jirex.Status, :create_statuses},
      url: "/rest/api/2/statuses",
      body: body,
      method: :post,
      request: [{"application/json", {Jirex.StatusCreateRequest, :t}}],
      response: [{200, [{Jirex.JiraStatus, :t}]}, {400, :unknown}, {401, :null}, {409, :null}],
      opts: opts
    })
  end

  @doc """
  Bulk delete Statuses

  Deletes statuses by ID.

  **[Permissions](#permissions) required:**

   *  *Administer projects* [project permission.](https://confluence.atlassian.com/x/yodKLg)
   *  *Administer Jira* [project permission.](https://confluence.atlassian.com/x/yodKLg)

  ## Options

    * `id`: The list of status IDs. To include multiple IDs, provide an ampersand-separated list. For example, id=10000&id=10001.

      Min items `1`, Max items `50`

  """
  @spec delete_statuses_by_id(keyword) :: {:ok, map} | {:error, any}
  def delete_statuses_by_id(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:id])

    client.request(%{
      args: [],
      call: {Jirex.Status, :delete_statuses_by_id},
      url: "/rest/api/2/statuses",
      method: :delete,
      query: query,
      response: [{204, :map}, {400, :unknown}, {401, :null}],
      opts: opts
    })
  end

  @doc """
  Bulk get statuses

  Returns a list of the statuses specified by one or more status IDs.

  **[Permissions](#permissions) required:**

   *  *Administer projects* [project permission.](https://confluence.atlassian.com/x/yodKLg)
   *  *Administer Jira* [project permission.](https://confluence.atlassian.com/x/yodKLg)

  ## Options

    * `expand`: Use [expand](#expansion) to include additional information in the response. This parameter accepts a comma-separated list. Expand options include:

       *  `usages` Returns the project and issue types that use the status in their workflow.
       *  `workflowUsages` Returns the workflows that use the status.
    * `id`: The list of status IDs. To include multiple IDs, provide an ampersand-separated list. For example, id=10000&id=10001.

      Min items `1`, Max items `50`

  """
  @spec get_statuses_by_id(keyword) :: {:ok, [Jirex.JiraStatus.t()]} | :error
  def get_statuses_by_id(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:expand, :id])

    client.request(%{
      args: [],
      call: {Jirex.Status, :get_statuses_by_id},
      url: "/rest/api/2/statuses",
      method: :get,
      query: query,
      response: [{200, [{Jirex.JiraStatus, :t}]}, {400, :null}, {401, :null}],
      opts: opts
    })
  end

  @doc """
  Search statuses paginated

  Returns a [paginated](https://developer.atlassian.com/cloud/jira/platform/rest/v3/intro/#pagination) list of statuses that match a search on name or project.

  **[Permissions](#permissions) required:**

   *  *Administer projects* [project permission.](https://confluence.atlassian.com/x/yodKLg)
   *  *Administer Jira* [project permission.](https://confluence.atlassian.com/x/yodKLg)

  ## Options

    * `expand`: Use [expand](#expansion) to include additional information in the response. This parameter accepts a comma-separated list. Expand options include:

       *  `usages` Returns the project and issue types that use the status in their workflow.
       *  `workflowUsages` Returns the workflows that use the status.
    * `projectId`: The project the status is part of or null for global statuses.
    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.
    * `searchString`: Term to match status names against or null to search for all statuses in the search scope.
    * `statusCategory`: Category of the status to filter by. The supported values are: `TODO`, `IN_PROGRESS`, and `DONE`.

  """
  @spec search(keyword) :: {:ok, Jirex.PageOfStatuses.t()} | :error
  def search(opts \\ []) do
    client = opts[:client] || @default_client

    query =
      Keyword.take(opts, [
        :expand,
        :maxResults,
        :projectId,
        :searchString,
        :startAt,
        :statusCategory
      ])

    client.request(%{
      args: [],
      call: {Jirex.Status, :search},
      url: "/rest/api/2/statuses/search",
      method: :get,
      query: query,
      response: [{200, {Jirex.PageOfStatuses, :t}}, {400, :null}, {401, :null}],
      opts: opts
    })
  end

  @doc """
  Bulk update statuses

  Updates statuses by ID.

  **[Permissions](#permissions) required:**

   *  *Administer projects* [project permission.](https://confluence.atlassian.com/x/yodKLg)
   *  *Administer Jira* [project permission.](https://confluence.atlassian.com/x/yodKLg)
  """
  @spec update_statuses(Jirex.StatusUpdateRequest.t(), keyword) :: {:ok, map} | {:error, any}
  def update_statuses(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jirex.Status, :update_statuses},
      url: "/rest/api/2/statuses",
      body: body,
      method: :put,
      request: [{"application/json", {Jirex.StatusUpdateRequest, :t}}],
      response: [{204, :map}, {400, :unknown}, {401, :null}, {409, :null}],
      opts: opts
    })
  end
end
