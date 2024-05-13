defmodule Jira.JQLFunctionsApps do
  @moduledoc """
  Provides API endpoints related to jql functions apps
  """

  @default_client Jira.Client

  @doc """
  Get precomputations (apps)

  Returns the list of a function's precomputations along with information about when they were created, updated, and last used. Each precomputation has a `value` \- the JQL fragment to replace the custom function clause with.

  **[Permissions](#permissions) required:** This API is only accessible to apps and apps can only inspect their own functions.

  ## Options

    * `functionKey`: The function key in format:
      
       *  Forge: `ari:cloud:ecosystem::extension/[App ID]/[Environment ID]/static/[Function key from manifest]`
       *  Connect: `[App key]__[Module key]`
    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.
    * `orderBy`: [Order](#ordering) the results by a field:
      
       *  `functionKey` Sorts by the functionKey.
       *  `used` Sorts by the used timestamp.
       *  `created` Sorts by the created timestamp.
       *  `updated` Sorts by the updated timestamp.

  """
  @spec get_precomputations(keyword) ::
          {:ok, Jira.PageBeanJqlFunctionPrecomputationBean.t()} | :error
  def get_precomputations(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:functionKey, :maxResults, :orderBy, :startAt])

    client.request(%{
      args: [],
      call: {Jira.JQLFunctionsApps, :get_precomputations},
      url: "/rest/api/2/jql/function/computation",
      method: :get,
      query: query,
      response: [
        {200, {Jira.PageBeanJqlFunctionPrecomputationBean, :t}},
        {400, :null},
        {401, :null},
        {403, :null},
        {404, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Update precomputations (apps)

  Update the precomputation value of a function created by a Forge/Connect app.

  **[Permissions](#permissions) required:** An API for apps to update their own precomputations.
  """
  @spec update_precomputations(Jira.JqlFunctionPrecomputationUpdateRequestBean.t(), keyword) ::
          {:ok, map} | :error
  def update_precomputations(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jira.JQLFunctionsApps, :update_precomputations},
      url: "/rest/api/2/jql/function/computation",
      body: body,
      method: :post,
      request: [{"application/json", {Jira.JqlFunctionPrecomputationUpdateRequestBean, :t}}],
      response: [{204, :map}, {400, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end
end
