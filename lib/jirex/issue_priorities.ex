defmodule Jirex.IssuePriorities do
  @moduledoc """
  Provides API endpoints related to issue priorities
  """

  @default_client Jirex.Client

  @doc """
  Create priority

  Creates an issue priority.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec create_priority(Jirex.CreatePriorityDetails.t(), keyword) ::
          {:ok, Jirex.PriorityId.t()} | {:error, Jirex.ErrorCollection.t()}
  def create_priority(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jirex.IssuePriorities, :create_priority},
      url: "/rest/api/2/priority",
      body: body,
      method: :post,
      request: [{"application/json", {Jirex.CreatePriorityDetails, :t}}],
      response: [
        {201, {Jirex.PriorityId, :t}},
        {400, {Jirex.ErrorCollection, :t}},
        {401, {Jirex.ErrorCollection, :t}},
        {403, {Jirex.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Delete priority

  *Deprecated: please refer to the* [changelog](https://developer.atlassian.com/changelog/#CHANGE-1066) *for more details.*

  Deletes an issue priority.

  This operation is [asynchronous](#async). Follow the `location` link in the response to determine the status of the task and use [Get task](#api-rest-api-2-task-taskId-get) to obtain subsequent updates.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `replaceWith`: The ID of the issue priority that will replace the currently selected resolution.

  """
  @spec delete_priority(String.t(), keyword) :: :ok | {:error, Jirex.ErrorCollection.t()}
  def delete_priority(id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:replaceWith])

    client.request(%{
      args: [id: id],
      call: {Jirex.IssuePriorities, :delete_priority},
      url: "/rest/api/2/priority/#{id}",
      method: :delete,
      query: query,
      response: [
        {303, {Jirex.TaskProgressBeanObject, :t}},
        {400, {Jirex.ErrorCollection, :t}},
        {401, {Jirex.ErrorCollection, :t}},
        {403, {Jirex.ErrorCollection, :t}},
        {404, {Jirex.ErrorCollection, :t}},
        {409, {Jirex.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get priorities

  Returns the list of all issue priorities.

  **[Permissions](#permissions) required:** Permission to access Jira.
  """
  @spec get_priorities(keyword) :: {:ok, [Jirex.Priority.t()]} | :error
  def get_priorities(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Jirex.IssuePriorities, :get_priorities},
      url: "/rest/api/2/priority",
      method: :get,
      response: [{200, [{Jirex.Priority, :t}]}, {401, :null}],
      opts: opts
    })
  end

  @doc """
  Get priority

  Returns an issue priority.

  **[Permissions](#permissions) required:** Permission to access Jira.
  """
  @spec get_priority(String.t(), keyword) :: {:ok, Jirex.Priority.t()} | :error
  def get_priority(id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id],
      call: {Jirex.IssuePriorities, :get_priority},
      url: "/rest/api/2/priority/#{id}",
      method: :get,
      response: [{200, {Jirex.Priority, :t}}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Move priorities

  Changes the order of issue priorities.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec move_priorities(Jirex.ReorderIssuePriorities.t(), keyword) ::
          {:ok, map} | {:error, Jirex.ErrorCollection.t()}
  def move_priorities(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jirex.IssuePriorities, :move_priorities},
      url: "/rest/api/2/priority/move",
      body: body,
      method: :put,
      request: [{"application/json", {Jirex.ReorderIssuePriorities, :t}}],
      response: [
        {204, :map},
        {400, {Jirex.ErrorCollection, :t}},
        {401, {Jirex.ErrorCollection, :t}},
        {403, {Jirex.ErrorCollection, :t}},
        {404, {Jirex.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Search priorities

  Returns a [paginated](#pagination) list of priorities. The list can contain all priorities or a subset determined by any combination of these criteria:

   *  a list of priority IDs. Any invalid priority IDs are ignored.
   *  a list of project IDs. Only priorities that are available in these projects will be returned. Any invalid project IDs are ignored.
   *  whether the field configuration is a default. This returns priorities from company-managed (classic) projects only, as there is no concept of default priorities in team-managed projects.

  **[Permissions](#permissions) required:** Permission to access Jira.

  ## Options

    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.
    * `id`: The list of priority IDs. To include multiple IDs, provide an ampersand-separated list. For example, `id=2&id=3`.
    * `projectId`: The list of projects IDs. To include multiple IDs, provide an ampersand-separated list. For example, `projectId=10010&projectId=10111`.
    * `priorityName`: The name of priority to search for.
    * `onlyDefault`: Whether only the default priority is returned.
    * `expand`: Use `schemes` to return the associated priority schemes for each priority. Limited to returning first 15 priority schemes per priority.

  """
  @spec search_priorities(keyword) ::
          {:ok, Jirex.PageBeanPriority.t()} | {:error, Jirex.ErrorCollection.t()}
  def search_priorities(opts \\ []) do
    client = opts[:client] || @default_client

    query =
      Keyword.take(opts, [
        :expand,
        :id,
        :maxResults,
        :onlyDefault,
        :priorityName,
        :projectId,
        :startAt
      ])

    client.request(%{
      args: [],
      call: {Jirex.IssuePriorities, :search_priorities},
      url: "/rest/api/2/priority/search",
      method: :get,
      query: query,
      response: [{200, {Jirex.PageBeanPriority, :t}}, {401, {Jirex.ErrorCollection, :t}}],
      opts: opts
    })
  end

  @doc """
  Set default priority

  Sets default issue priority.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec set_default_priority(Jirex.SetDefaultPriorityRequest.t(), keyword) ::
          {:ok, map} | {:error, Jirex.ErrorCollection.t()}
  def set_default_priority(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jirex.IssuePriorities, :set_default_priority},
      url: "/rest/api/2/priority/default",
      body: body,
      method: :put,
      request: [{"application/json", {Jirex.SetDefaultPriorityRequest, :t}}],
      response: [
        {204, :map},
        {400, {Jirex.ErrorCollection, :t}},
        {401, {Jirex.ErrorCollection, :t}},
        {403, {Jirex.ErrorCollection, :t}},
        {404, {Jirex.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Update priority

  Updates an issue priority.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec update_priority(String.t(), Jirex.UpdatePriorityDetails.t(), keyword) ::
          {:ok, map} | {:error, Jirex.ErrorCollection.t()}
  def update_priority(id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id, body: body],
      call: {Jirex.IssuePriorities, :update_priority},
      url: "/rest/api/2/priority/#{id}",
      body: body,
      method: :put,
      request: [{"application/json", {Jirex.UpdatePriorityDetails, :t}}],
      response: [
        {204, :map},
        {400, {Jirex.ErrorCollection, :t}},
        {401, {Jirex.ErrorCollection, :t}},
        {403, {Jirex.ErrorCollection, :t}},
        {404, {Jirex.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end
end
