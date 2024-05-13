defmodule Jira.IssueResolutions do
  @moduledoc """
  Provides API endpoints related to issue resolutions
  """

  @default_client Jira.Client

  @doc """
  Create resolution

  Creates an issue resolution.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec create_resolution(Jira.CreateResolutionDetails.t(), keyword) ::
          {:ok, Jira.ResolutionId.t()} | {:error, Jira.ErrorCollection.t()}
  def create_resolution(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jira.IssueResolutions, :create_resolution},
      url: "/rest/api/2/resolution",
      body: body,
      method: :post,
      request: [{"application/json", {Jira.CreateResolutionDetails, :t}}],
      response: [
        {201, {Jira.ResolutionId, :t}},
        {400, {Jira.ErrorCollection, :t}},
        {401, {Jira.ErrorCollection, :t}},
        {403, {Jira.ErrorCollection, :t}}
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
  @spec delete_resolution(String.t(), keyword) :: :ok | {:error, Jira.ErrorCollection.t()}
  def delete_resolution(id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:replaceWith])

    client.request(%{
      args: [id: id],
      call: {Jira.IssueResolutions, :delete_resolution},
      url: "/rest/api/2/resolution/#{id}",
      method: :delete,
      query: query,
      response: [
        {303, {Jira.TaskProgressBeanObject, :t}},
        {400, {Jira.ErrorCollection, :t}},
        {401, {Jira.ErrorCollection, :t}},
        {403, {Jira.ErrorCollection, :t}},
        {404, {Jira.ErrorCollection, :t}},
        {409, {Jira.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get resolution

  Returns an issue resolution value.

  **[Permissions](#permissions) required:** Permission to access Jira.
  """
  @spec get_resolution(String.t(), keyword) :: {:ok, Jira.Resolution.t()} | :error
  def get_resolution(id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id],
      call: {Jira.IssueResolutions, :get_resolution},
      url: "/rest/api/2/resolution/#{id}",
      method: :get,
      response: [{200, {Jira.Resolution, :t}}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get resolutions

  Returns a list of all issue resolution values.

  **[Permissions](#permissions) required:** Permission to access Jira.
  """
  @spec get_resolutions(keyword) :: {:ok, [Jira.Resolution.t()]} | :error
  def get_resolutions(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Jira.IssueResolutions, :get_resolutions},
      url: "/rest/api/2/resolution",
      method: :get,
      response: [{200, [{Jira.Resolution, :t}]}, {401, :null}],
      opts: opts
    })
  end

  @doc """
  Move resolutions

  Changes the order of issue resolutions.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec move_resolutions(Jira.ReorderIssueResolutionsRequest.t(), keyword) ::
          {:ok, map} | {:error, Jira.ErrorCollection.t()}
  def move_resolutions(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jira.IssueResolutions, :move_resolutions},
      url: "/rest/api/2/resolution/move",
      body: body,
      method: :put,
      request: [{"application/json", {Jira.ReorderIssueResolutionsRequest, :t}}],
      response: [
        {204, :map},
        {400, {Jira.ErrorCollection, :t}},
        {401, {Jira.ErrorCollection, :t}},
        {403, {Jira.ErrorCollection, :t}},
        {404, {Jira.ErrorCollection, :t}}
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
          {:ok, Jira.PageBeanResolutionJsonBean.t()} | {:error, Jira.ErrorCollection.t()}
  def search_resolutions(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:id, :maxResults, :onlyDefault, :startAt])

    client.request(%{
      args: [],
      call: {Jira.IssueResolutions, :search_resolutions},
      url: "/rest/api/2/resolution/search",
      method: :get,
      query: query,
      response: [{200, {Jira.PageBeanResolutionJsonBean, :t}}, {401, {Jira.ErrorCollection, :t}}],
      opts: opts
    })
  end

  @doc """
  Set default resolution

  Sets default issue resolution.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec set_default_resolution(Jira.SetDefaultResolutionRequest.t(), keyword) ::
          {:ok, map} | {:error, Jira.ErrorCollection.t()}
  def set_default_resolution(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jira.IssueResolutions, :set_default_resolution},
      url: "/rest/api/2/resolution/default",
      body: body,
      method: :put,
      request: [{"application/json", {Jira.SetDefaultResolutionRequest, :t}}],
      response: [
        {204, :map},
        {400, {Jira.ErrorCollection, :t}},
        {401, {Jira.ErrorCollection, :t}},
        {403, {Jira.ErrorCollection, :t}},
        {404, {Jira.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Update resolution

  Updates an issue resolution.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec update_resolution(String.t(), Jira.UpdateResolutionDetails.t(), keyword) ::
          {:ok, map} | {:error, Jira.ErrorCollection.t()}
  def update_resolution(id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id, body: body],
      call: {Jira.IssueResolutions, :update_resolution},
      url: "/rest/api/2/resolution/#{id}",
      body: body,
      method: :put,
      request: [{"application/json", {Jira.UpdateResolutionDetails, :t}}],
      response: [
        {204, :map},
        {400, {Jira.ErrorCollection, :t}},
        {401, {Jira.ErrorCollection, :t}},
        {403, {Jira.ErrorCollection, :t}},
        {404, {Jira.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end
end
