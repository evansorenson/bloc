defmodule Jirex.IssueResolutions do
  @moduledoc """
  Provides API endpoints related to issue resolutions
  """

  @default_client Jirex.Client

  @doc """
  Create resolution

  Creates an issue resolution.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec create_resolution(Jirex.CreateResolutionDetails.t(), keyword) ::
          {:ok, Jirex.ResolutionId.t()} | {:error, Jirex.ErrorCollection.t()}
  def create_resolution(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jirex.IssueResolutions, :create_resolution},
      url: "/rest/api/2/resolution",
      body: body,
      method: :post,
      request: [{"application/json", {Jirex.CreateResolutionDetails, :t}}],
      response: [
        {201, {Jirex.ResolutionId, :t}},
        {400, {Jirex.ErrorCollection, :t}},
        {401, {Jirex.ErrorCollection, :t}},
        {403, {Jirex.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Delete resolution

  Deletes an issue resolution.

  This operation is [asynchronous](#async). Follow the `location` link in the response to determine the status of the task and use [Get task](#api-rest-api-2-task-taskId-get) to obtain subsequent updates.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `replaceWith`: The ID of the issue resolution that will replace the currently selected resolution.

  """
  @spec delete_resolution(String.t(), keyword) :: :ok | {:error, Jirex.ErrorCollection.t()}
  def delete_resolution(id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:replaceWith])

    client.request(%{
      args: [id: id],
      call: {Jirex.IssueResolutions, :delete_resolution},
      url: "/rest/api/2/resolution/#{id}",
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
  Get resolution

  Returns an issue resolution value.

  **[Permissions](#permissions) required:** Permission to access Jira.
  """
  @spec get_resolution(String.t(), keyword) :: {:ok, Jirex.Resolution.t()} | :error
  def get_resolution(id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id],
      call: {Jirex.IssueResolutions, :get_resolution},
      url: "/rest/api/2/resolution/#{id}",
      method: :get,
      response: [{200, {Jirex.Resolution, :t}}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get resolutions

  Returns a list of all issue resolution values.

  **[Permissions](#permissions) required:** Permission to access Jira.
  """
  @spec get_resolutions(keyword) :: {:ok, [Jirex.Resolution.t()]} | :error
  def get_resolutions(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Jirex.IssueResolutions, :get_resolutions},
      url: "/rest/api/2/resolution",
      method: :get,
      response: [{200, [{Jirex.Resolution, :t}]}, {401, :null}],
      opts: opts
    })
  end

  @doc """
  Move resolutions

  Changes the order of issue resolutions.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec move_resolutions(Jirex.ReorderIssueResolutionsRequest.t(), keyword) ::
          {:ok, map} | {:error, Jirex.ErrorCollection.t()}
  def move_resolutions(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jirex.IssueResolutions, :move_resolutions},
      url: "/rest/api/2/resolution/move",
      body: body,
      method: :put,
      request: [{"application/json", {Jirex.ReorderIssueResolutionsRequest, :t}}],
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
  Search resolutions

  Returns a [paginated](#pagination) list of resolutions. The list can contain all resolutions or a subset determined by any combination of these criteria:

   *  a list of resolutions IDs.
   *  whether the field configuration is a default. This returns resolutions from company-managed (classic) projects only, as there is no concept of default resolutions in team-managed projects.

  **[Permissions](#permissions) required:** Permission to access Jira.

  ## Options

    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.
    * `id`: The list of resolutions IDs to be filtered out
    * `onlyDefault`: When set to true, return default only, when IDs provided, if none of them is default, return empty page. Default value is false

  """
  @spec search_resolutions(keyword) ::
          {:ok, Jirex.PageBeanResolutionJsonBean.t()} | {:error, Jirex.ErrorCollection.t()}
  def search_resolutions(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:id, :maxResults, :onlyDefault, :startAt])

    client.request(%{
      args: [],
      call: {Jirex.IssueResolutions, :search_resolutions},
      url: "/rest/api/2/resolution/search",
      method: :get,
      query: query,
      response: [
        {200, {Jirex.PageBeanResolutionJsonBean, :t}},
        {401, {Jirex.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Set default resolution

  Sets default issue resolution.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec set_default_resolution(Jirex.SetDefaultResolutionRequest.t(), keyword) ::
          {:ok, map} | {:error, Jirex.ErrorCollection.t()}
  def set_default_resolution(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jirex.IssueResolutions, :set_default_resolution},
      url: "/rest/api/2/resolution/default",
      body: body,
      method: :put,
      request: [{"application/json", {Jirex.SetDefaultResolutionRequest, :t}}],
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
  Update resolution

  Updates an issue resolution.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec update_resolution(String.t(), Jirex.UpdateResolutionDetails.t(), keyword) ::
          {:ok, map} | {:error, Jirex.ErrorCollection.t()}
  def update_resolution(id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id, body: body],
      call: {Jirex.IssueResolutions, :update_resolution},
      url: "/rest/api/2/resolution/#{id}",
      body: body,
      method: :put,
      request: [{"application/json", {Jirex.UpdateResolutionDetails, :t}}],
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
