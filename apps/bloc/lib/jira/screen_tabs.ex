defmodule Jira.ScreenTabs do
  @moduledoc """
  Provides API endpoints related to screen tabs
  """

  @default_client Jira.Client

  @doc """
  Create screen tab

  Creates a tab for a screen.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec add_screen_tab(integer, Jira.ScreenableTab.t(), keyword) ::
          {:ok, Jira.ScreenableTab.t()} | :error
  def add_screen_tab(screenId, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [screenId: screenId, body: body],
      call: {Jira.ScreenTabs, :add_screen_tab},
      url: "/rest/api/2/screens/#{screenId}/tabs",
      body: body,
      method: :post,
      request: [{"application/json", {Jira.ScreenableTab, :t}}],
      response: [
        {200, {Jira.ScreenableTab, :t}},
        {400, :null},
        {401, :null},
        {403, :null},
        {404, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Delete screen tab

  Deletes a screen tab.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec delete_screen_tab(integer, integer, keyword) :: :ok | :error
  def delete_screen_tab(screenId, tabId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [screenId: screenId, tabId: tabId],
      call: {Jira.ScreenTabs, :delete_screen_tab},
      url: "/rest/api/2/screens/#{screenId}/tabs/#{tabId}",
      method: :delete,
      response: [{204, :null}, {401, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get all screen tabs

  Returns the list of tabs for a screen.

  **[Permissions](#permissions) required:**

   *  *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
   *  *Administer projects* [project permission](https://confluence.atlassian.com/x/yodKLg) when the project key is specified, providing that the screen is associated with the project through a Screen Scheme and Issue Type Screen Scheme.

  ## Options

    * `projectKey`: The key of the project.

  """
  @spec get_all_screen_tabs(integer, keyword) :: {:ok, [Jira.ScreenableTab.t()]} | :error
  def get_all_screen_tabs(screenId, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:projectKey])

    client.request(%{
      args: [screenId: screenId],
      call: {Jira.ScreenTabs, :get_all_screen_tabs},
      url: "/rest/api/2/screens/#{screenId}/tabs",
      method: :get,
      query: query,
      response: [
        {200, [{Jira.ScreenableTab, :t}]},
        {400, :null},
        {401, :null},
        {403, :null},
        {404, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Get bulk screen tabs

  Returns the list of tabs for a bulk of screens.

  **[Permissions](#permissions) required:**

   *  *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `screenId`: The list of screen IDs. To include multiple screen IDs, provide an ampersand-separated list. For example, `screenId=10000&screenId=10001`.
    * `tabId`: The list of tab IDs. To include multiple tab IDs, provide an ampersand-separated list. For example, `tabId=10000&tabId=10001`.
    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResult`: The maximum number of items to return per page. The maximum number is 100,

  """
  @spec get_bulk_screen_tabs(keyword) :: {:ok, any} | :error
  def get_bulk_screen_tabs(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:maxResult, :screenId, :startAt, :tabId])

    client.request(%{
      args: [],
      call: {Jira.ScreenTabs, :get_bulk_screen_tabs},
      url: "/rest/api/2/screens/tabs",
      method: :get,
      query: query,
      response: [{200, :unknown}, {400, :null}, {401, :null}, {403, :null}],
      opts: opts
    })
  end

  @doc """
  Move screen tab

  Moves a screen tab.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec move_screen_tab(integer, integer, integer, keyword) :: {:ok, map} | :error
  def move_screen_tab(screenId, tabId, pos, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [screenId: screenId, tabId: tabId, pos: pos],
      call: {Jira.ScreenTabs, :move_screen_tab},
      url: "/rest/api/2/screens/#{screenId}/tabs/#{tabId}/move/#{pos}",
      method: :post,
      response: [{204, :map}, {400, :null}, {401, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Update screen tab

  Updates the name of a screen tab.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec rename_screen_tab(integer, integer, Jira.ScreenableTab.t(), keyword) ::
          {:ok, Jira.ScreenableTab.t()} | :error
  def rename_screen_tab(screenId, tabId, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [screenId: screenId, tabId: tabId, body: body],
      call: {Jira.ScreenTabs, :rename_screen_tab},
      url: "/rest/api/2/screens/#{screenId}/tabs/#{tabId}",
      body: body,
      method: :put,
      request: [{"application/json", {Jira.ScreenableTab, :t}}],
      response: [
        {200, {Jira.ScreenableTab, :t}},
        {400, :null},
        {401, :null},
        {403, :null},
        {404, :null}
      ],
      opts: opts
    })
  end
end
