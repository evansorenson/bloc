defmodule Jirex.PrioritySchemes do
  @moduledoc """
  Provides API endpoints related to priority schemes
  """

  @default_client Jirex.Client

  @doc """
  Create priority scheme

  Creates a new priority scheme.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec create_priority_scheme(Jirex.CreatePrioritySchemeDetails.t(), keyword) ::
          {:ok, Jirex.PrioritySchemeId.t()} | :error
  def create_priority_scheme(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jirex.PrioritySchemes, :create_priority_scheme},
      url: "/rest/api/2/priorityscheme",
      body: body,
      method: :post,
      request: [{"application/json", {Jirex.CreatePrioritySchemeDetails, :t}}],
      response: [
        {201, {Jirex.PrioritySchemeId, :t}},
        {202, {Jirex.PrioritySchemeId, :t}},
        {400, :null},
        {401, :null},
        {403, :null},
        {409, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Delete priority scheme

  Deletes a priority scheme.

  This operation is only available for priority schemes without any associated projects. Any associated projects must be removed from the priority scheme before this operation can be performed.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec delete_priority_scheme(integer, keyword) :: {:ok, map} | :error
  def delete_priority_scheme(schemeId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [schemeId: schemeId],
      call: {Jirex.PrioritySchemes, :delete_priority_scheme},
      url: "/rest/api/2/priorityscheme/#{schemeId}",
      method: :delete,
      response: [{204, :map}, {400, :null}, {401, :null}, {403, :null}],
      opts: opts
    })
  end

  @doc """
  Get available priorities by priority scheme

  Returns a [paginated](#pagination) list of priorities available for adding to a priority scheme.

  **[Permissions](#permissions) required:** Permission to access Jira.

  ## Options

    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.
    * `query`: The string to query priorities on by name.
    * `schemeId`: The priority scheme ID.
    * `exclude`: A list of priority IDs to exclude from the results.

  """
  @spec get_available_priorities_by_priority_scheme(keyword) ::
          {:ok, Jirex.PageBeanPriorityWithSequence.t()} | :error
  def get_available_priorities_by_priority_scheme(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:exclude, :maxResults, :query, :schemeId, :startAt])

    client.request(%{
      args: [],
      call: {Jirex.PrioritySchemes, :get_available_priorities_by_priority_scheme},
      url: "/rest/api/2/priorityscheme/priorities/available",
      method: :get,
      query: query,
      response: [{200, {Jirex.PageBeanPriorityWithSequence, :t}}, {400, :null}, {401, :null}],
      opts: opts
    })
  end

  @doc """
  Get priorities by priority scheme

  Returns a [paginated](#pagination) list of priorities by scheme.

  **[Permissions](#permissions) required:** Permission to access Jira.

  ## Options

    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.

  """
  @spec get_priorities_by_priority_scheme(String.t(), keyword) ::
          {:ok, Jirex.PageBeanPriorityWithSequence.t()} | :error
  def get_priorities_by_priority_scheme(schemeId, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:maxResults, :startAt])

    client.request(%{
      args: [schemeId: schemeId],
      call: {Jirex.PrioritySchemes, :get_priorities_by_priority_scheme},
      url: "/rest/api/2/priorityscheme/#{schemeId}/priorities",
      method: :get,
      query: query,
      response: [{200, {Jirex.PageBeanPriorityWithSequence, :t}}, {400, :null}, {401, :null}],
      opts: opts
    })
  end

  @doc """
  Get priority schemes

  Returns a [paginated](#pagination) list of priority schemes.

  **[Permissions](#permissions) required:** Permission to access Jira.

  ## Options

    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.
    * `priorityId`: A set of priority IDs to filter by. To include multiple IDs, provide an ampersand-separated list. For example, `priorityId=10000&priorityId=10001`.
    * `schemeId`: A set of priority scheme IDs. To include multiple IDs, provide an ampersand-separated list. For example, `schemeId=10000&schemeId=10001`.
    * `schemeName`: The name of scheme to search for.
    * `onlyDefault`: Whether only the default priority is returned.
    * `orderBy`: The ordering to return the priority schemes by.
    * `expand`: A comma separated list of additional information to return. "priorities" will return priorities associated with the priority scheme. "projects" will return projects associated with the priority scheme. `expand=priorities,projects`.

  """
  @spec get_priority_schemes(keyword) ::
          {:ok, Jirex.PageBeanPrioritySchemeWithPaginatedPrioritiesAndProjects.t()} | :error
  def get_priority_schemes(opts \\ []) do
    client = opts[:client] || @default_client

    query =
      Keyword.take(opts, [
        :expand,
        :maxResults,
        :onlyDefault,
        :orderBy,
        :priorityId,
        :schemeId,
        :schemeName,
        :startAt
      ])

    client.request(%{
      args: [],
      call: {Jirex.PrioritySchemes, :get_priority_schemes},
      url: "/rest/api/2/priorityscheme",
      method: :get,
      query: query,
      response: [
        {200, {Jirex.PageBeanPrioritySchemeWithPaginatedPrioritiesAndProjects, :t}},
        {400, :null},
        {401, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Get projects by priority scheme

  Returns a [paginated](#pagination) list of projects by scheme.

  **[Permissions](#permissions) required:** Permission to access Jira.

  ## Options

    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.
    * `projectId`: The project IDs to filter by. For example, `projectId=10000&projectId=10001`.
    * `query`: The string to query projects on by name.

  """
  @spec get_projects_by_priority_scheme(String.t(), keyword) ::
          {:ok, Jirex.PageBeanProject.t()} | :error
  def get_projects_by_priority_scheme(schemeId, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:maxResults, :projectId, :query, :startAt])

    client.request(%{
      args: [schemeId: schemeId],
      call: {Jirex.PrioritySchemes, :get_projects_by_priority_scheme},
      url: "/rest/api/2/priorityscheme/#{schemeId}/projects",
      method: :get,
      query: query,
      response: [{200, {Jirex.PageBeanProject, :t}}, {400, :null}, {401, :null}],
      opts: opts
    })
  end

  @doc """
  Suggested priorities for mappings

  Returns a [paginated](#pagination) list of priorities that would require mapping, given a change in priorities or projects associated with a priority scheme.

  **[Permissions](#permissions) required:** Permission to access Jira.
  """
  @spec suggested_priorities_for_mappings(Jirex.SuggestedMappingsRequestBean.t(), keyword) ::
          {:ok, Jirex.PageBeanPriorityWithSequence.t()} | :error
  def suggested_priorities_for_mappings(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jirex.PrioritySchemes, :suggested_priorities_for_mappings},
      url: "/rest/api/2/priorityscheme/mappings",
      body: body,
      method: :post,
      request: [{"application/json", {Jirex.SuggestedMappingsRequestBean, :t}}],
      response: [{200, {Jirex.PageBeanPriorityWithSequence, :t}}, {400, :null}, {401, :null}],
      opts: opts
    })
  end

  @doc """
  Update priority scheme

  Updates a priority scheme. This includes its details, the lists of priorities and projects in it

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec update_priority_scheme(integer, Jirex.UpdatePrioritySchemeRequestBean.t(), keyword) ::
          {:ok, Jirex.UpdatePrioritySchemeResponseBean.t()} | :error
  def update_priority_scheme(schemeId, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [schemeId: schemeId, body: body],
      call: {Jirex.PrioritySchemes, :update_priority_scheme},
      url: "/rest/api/2/priorityscheme/#{schemeId}",
      body: body,
      method: :put,
      request: [{"application/json", {Jirex.UpdatePrioritySchemeRequestBean, :t}}],
      response: [
        {202, {Jirex.UpdatePrioritySchemeResponseBean, :t}},
        {400, :null},
        {401, :null},
        {403, :null},
        {409, :null}
      ],
      opts: opts
    })
  end
end
