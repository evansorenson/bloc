defmodule Jira.ScreenSchemes do
  @moduledoc """
  Provides API endpoints related to screen schemes
  """

  @default_client Jira.Client

  @doc """
  Create screen scheme

  Creates a screen scheme.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec create_screen_scheme(Jira.ScreenSchemeDetails.t(), keyword) ::
          {:ok, Jira.ScreenSchemeId.t()} | {:error, any}
  def create_screen_scheme(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jira.ScreenSchemes, :create_screen_scheme},
      url: "/rest/api/2/screenscheme",
      body: body,
      method: :post,
      request: [{"application/json", {Jira.ScreenSchemeDetails, :t}}],
      response: [
        {201, {Jira.ScreenSchemeId, :t}},
        {400, :unknown},
        {401, :null},
        {403, :unknown},
        {404, :unknown}
      ],
      opts: opts
    })
  end

  @doc """
  Delete screen scheme

  Deletes a screen scheme. A screen scheme cannot be deleted if it is used in an issue type screen scheme.

  Only screens schemes used in classic projects can be deleted.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec delete_screen_scheme(String.t(), keyword) :: :ok | {:error, any}
  def delete_screen_scheme(screenSchemeId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [screenSchemeId: screenSchemeId],
      call: {Jira.ScreenSchemes, :delete_screen_scheme},
      url: "/rest/api/2/screenscheme/#{screenSchemeId}",
      method: :delete,
      response: [{204, :null}, {400, :unknown}, {401, :null}, {403, :unknown}, {404, :unknown}],
      opts: opts
    })
  end

  @doc """
  Get screen schemes

  Returns a [paginated](#pagination) list of screen schemes.

  Only screen schemes used in classic projects are returned.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.
    * `id`: The list of screen scheme IDs. To include multiple IDs, provide an ampersand-separated list. For example, `id=10000&id=10001`.
    * `expand`: Use [expand](#expansion) include additional information in the response. This parameter accepts `issueTypeScreenSchemes` that, for each screen schemes, returns information about the issue type screen scheme the screen scheme is assigned to.
    * `queryString`: String used to perform a case-insensitive partial match with screen scheme name.
    * `orderBy`: [Order](#ordering) the results by a field:
      
       *  `id` Sorts by screen scheme ID.
       *  `name` Sorts by screen scheme name.

  """
  @spec get_screen_schemes(keyword) :: {:ok, Jira.PageBeanScreenScheme.t()} | :error
  def get_screen_schemes(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:expand, :id, :maxResults, :orderBy, :queryString, :startAt])

    client.request(%{
      args: [],
      call: {Jira.ScreenSchemes, :get_screen_schemes},
      url: "/rest/api/2/screenscheme",
      method: :get,
      query: query,
      response: [{200, {Jira.PageBeanScreenScheme, :t}}, {401, :null}, {403, :null}],
      opts: opts
    })
  end

  @doc """
  Update screen scheme

  Updates a screen scheme. Only screen schemes used in classic projects can be updated.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec update_screen_scheme(String.t(), Jira.UpdateScreenSchemeDetails.t(), keyword) ::
          {:ok, map} | {:error, any}
  def update_screen_scheme(screenSchemeId, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [screenSchemeId: screenSchemeId, body: body],
      call: {Jira.ScreenSchemes, :update_screen_scheme},
      url: "/rest/api/2/screenscheme/#{screenSchemeId}",
      body: body,
      method: :put,
      request: [{"application/json", {Jira.UpdateScreenSchemeDetails, :t}}],
      response: [{204, :map}, {400, :unknown}, {401, :null}, {403, :unknown}, {404, :unknown}],
      opts: opts
    })
  end
end
