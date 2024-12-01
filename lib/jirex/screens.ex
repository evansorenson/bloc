defmodule Jirex.Screens do
  @moduledoc """
  Provides API endpoints related to screens
  """

  @default_client Jirex.Client

  @doc """
  Add field to default screen

  Adds a field to the default tab of the default screen.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec add_field_to_default_screen(String.t(), keyword) :: {:ok, map} | :error
  def add_field_to_default_screen(fieldId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [fieldId: fieldId],
      call: {Jirex.Screens, :add_field_to_default_screen},
      url: "/rest/api/2/screens/addToDefault/#{fieldId}",
      method: :post,
      response: [{200, :map}, {400, :null}, {401, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Create screen

  Creates a screen with a default field tab.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec create_screen(Jirex.ScreenDetails.t(), keyword) :: {:ok, Jirex.Screen.t()} | {:error, any}
  def create_screen(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jirex.Screens, :create_screen},
      url: "/rest/api/2/screens",
      body: body,
      method: :post,
      request: [{"application/json", {Jirex.ScreenDetails, :t}}],
      response: [{201, {Jirex.Screen, :t}}, {400, :unknown}, {401, :null}, {403, :unknown}],
      opts: opts
    })
  end

  @doc """
  Delete screen

  Deletes a screen. A screen cannot be deleted if it is used in a screen scheme, workflow, or workflow draft.

  Only screens used in classic projects can be deleted.
  """
  @spec delete_screen(integer, keyword) :: :ok | {:error, any}
  def delete_screen(screenId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [screenId: screenId],
      call: {Jirex.Screens, :delete_screen},
      url: "/rest/api/2/screens/#{screenId}",
      method: :delete,
      response: [{204, :null}, {400, :unknown}, {401, :null}, {403, :unknown}, {404, :unknown}],
      opts: opts
    })
  end

  @doc """
  Get available screen fields

  Returns the fields that can be added to a tab on a screen.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec get_available_screen_fields(integer, keyword) ::
          {:ok, [Jirex.ScreenableField.t()]} | :error
  def get_available_screen_fields(screenId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [screenId: screenId],
      call: {Jirex.Screens, :get_available_screen_fields},
      url: "/rest/api/2/screens/#{screenId}/availableFields",
      method: :get,
      response: [{200, [{Jirex.ScreenableField, :t}]}, {401, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get screens

  Returns a [paginated](#pagination) list of all screens or those specified by one or more screen IDs.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.
    * `id`: The list of screen IDs. To include multiple IDs, provide an ampersand-separated list. For example, `id=10000&id=10001`.
    * `queryString`: String used to perform a case-insensitive partial match with screen name.
    * `scope`: The scope filter string. To filter by multiple scope, provide an ampersand-separated list. For example, `scope=GLOBAL&scope=PROJECT`.
    * `orderBy`: [Order](#ordering) the results by a field:

       *  `id` Sorts by screen ID.
       *  `name` Sorts by screen name.

  """
  @spec get_screens(keyword) :: {:ok, Jirex.PageBeanScreen.t()} | :error
  def get_screens(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:id, :maxResults, :orderBy, :queryString, :scope, :startAt])

    client.request(%{
      args: [],
      call: {Jirex.Screens, :get_screens},
      url: "/rest/api/2/screens",
      method: :get,
      query: query,
      response: [{200, {Jirex.PageBeanScreen, :t}}, {401, :null}, {403, :null}],
      opts: opts
    })
  end

  @doc """
  Get screens for a field

  Returns a [paginated](#pagination) list of the screens a field is used in.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.
    * `expand`: Use [expand](#expansion) to include additional information about screens in the response. This parameter accepts `tab` which returns details about the screen tabs the field is used in.

  """
  @spec get_screens_for_field(String.t(), keyword) ::
          {:ok, Jirex.PageBeanScreenWithTab.t()} | :error
  def get_screens_for_field(fieldId, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:expand, :maxResults, :startAt])

    client.request(%{
      args: [fieldId: fieldId],
      call: {Jirex.Screens, :get_screens_for_field},
      url: "/rest/api/2/field/#{fieldId}/screens",
      method: :get,
      query: query,
      response: [{200, {Jirex.PageBeanScreenWithTab, :t}}, {401, :null}, {403, :null}],
      opts: opts
    })
  end

  @doc """
  Update screen

  Updates a screen. Only screens used in classic projects can be updated.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec update_screen(integer, Jirex.UpdateScreenDetails.t(), keyword) ::
          {:ok, Jirex.Screen.t()} | {:error, any}
  def update_screen(screenId, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [screenId: screenId, body: body],
      call: {Jirex.Screens, :update_screen},
      url: "/rest/api/2/screens/#{screenId}",
      body: body,
      method: :put,
      request: [{"application/json", {Jirex.UpdateScreenDetails, :t}}],
      response: [
        {200, {Jirex.Screen, :t}},
        {400, :unknown},
        {401, :null},
        {403, :unknown},
        {404, :unknown}
      ],
      opts: opts
    })
  end
end
