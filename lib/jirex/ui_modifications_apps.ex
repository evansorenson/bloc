defmodule Jirex.UIModificationsApps do
  @moduledoc """
  Provides API endpoints related to ui modifications apps
  """

  @default_client Jirex.Client

  @doc """
  Create UI modification

  Creates a UI modification. UI modification can only be created by Forge apps.

  Each app can define up to 3000 UI modifications. Each UI modification can define up to 1000 contexts. The same context can be assigned to maximum 100 UI modifications.

  **[Permissions](#permissions) required:**

   *  *None* if the UI modification is created without contexts.
   *  *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for one or more projects, if the UI modification is created with contexts.
  """
  @spec create_ui_modification(Jirex.CreateUiModificationDetails.t(), keyword) ::
          {:ok, Jirex.UiModificationIdentifiers.t()} | {:error, Jirex.DetailedErrorCollection.t()}
  def create_ui_modification(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jirex.UIModificationsApps, :create_ui_modification},
      url: "/rest/api/2/uiModifications",
      body: body,
      method: :post,
      request: [{"application/json", {Jirex.CreateUiModificationDetails, :t}}],
      response: [
        {201, {Jirex.UiModificationIdentifiers, :t}},
        {400, :null},
        {401, :null},
        {403, :null},
        {404, {Jirex.DetailedErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Delete UI modification

  Deletes a UI modification. All the contexts that belong to the UI modification are deleted too. UI modification can only be deleted by Forge apps.

  **[Permissions](#permissions) required:** None.
  """
  @spec delete_ui_modification(String.t(), keyword) :: {:ok, map} | :error
  def delete_ui_modification(uiModificationId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [uiModificationId: uiModificationId],
      call: {Jirex.UIModificationsApps, :delete_ui_modification},
      url: "/rest/api/2/uiModifications/#{uiModificationId}",
      method: :delete,
      response: [{204, :map}, {401, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get UI modifications

  Gets UI modifications. UI modifications can only be retrieved by Forge apps.

  **[Permissions](#permissions) required:** None.

  ## Options

    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.
    * `expand`: Use expand to include additional information in the response. This parameter accepts a comma-separated list. Expand options include:

       *  `data` Returns UI modification data.
       *  `contexts` Returns UI modification contexts.

  """
  @spec get_ui_modifications(keyword) :: {:ok, Jirex.PageBeanUiModificationDetails.t()} | :error
  def get_ui_modifications(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:expand, :maxResults, :startAt])

    client.request(%{
      args: [],
      call: {Jirex.UIModificationsApps, :get_ui_modifications},
      url: "/rest/api/2/uiModifications",
      method: :get,
      query: query,
      response: [
        {200, {Jirex.PageBeanUiModificationDetails, :t}},
        {400, :null},
        {401, :null},
        {403, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Update UI modification

  Updates a UI modification. UI modification can only be updated by Forge apps.

  Each UI modification can define up to 1000 contexts. The same context can be assigned to maximum 100 UI modifications.

  **[Permissions](#permissions) required:**

   *  *None* if the UI modification is created without contexts.
   *  *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for one or more projects, if the UI modification is created with contexts.
  """
  @spec update_ui_modification(String.t(), Jirex.UpdateUiModificationDetails.t(), keyword) ::
          {:ok, map} | {:error, Jirex.DetailedErrorCollection.t()}
  def update_ui_modification(uiModificationId, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [uiModificationId: uiModificationId, body: body],
      call: {Jirex.UIModificationsApps, :update_ui_modification},
      url: "/rest/api/2/uiModifications/#{uiModificationId}",
      body: body,
      method: :put,
      request: [{"application/json", {Jirex.UpdateUiModificationDetails, :t}}],
      response: [
        {204, :map},
        {400, :null},
        {401, :null},
        {403, :null},
        {404, {Jirex.DetailedErrorCollection, :t}}
      ],
      opts: opts
    })
  end
end
