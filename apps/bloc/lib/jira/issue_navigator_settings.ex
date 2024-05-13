defmodule Jira.IssueNavigatorSettings do
  @moduledoc """
  Provides API endpoints related to issue navigator settings
  """

  @default_client Jira.Client

  @doc """
  Get issue navigator default columns

  Returns the default issue navigator columns.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec get_issue_navigator_default_columns(keyword) ::
          {:ok, [Jira.ColumnItem.t()]} | {:error, Jira.ErrorCollection.t()}
  def get_issue_navigator_default_columns(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Jira.IssueNavigatorSettings, :get_issue_navigator_default_columns},
      url: "/rest/api/2/settings/columns",
      method: :get,
      response: [
        {200, [{Jira.ColumnItem, :t}]},
        {401, {Jira.ErrorCollection, :t}},
        {403, {Jira.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Set issue navigator default columns

  Sets the default issue navigator columns.

  The `columns` parameter accepts a navigable field value and is expressed as HTML form data. To specify multiple columns, pass multiple `columns` parameters. For example, in curl:

  `curl -X PUT -d columns=summary -d columns=description https://your-domain.atlassian.net/rest/api/2/settings/columns`

  If no column details are sent, then all default columns are removed.

  A navigable field is one that can be used as a column on the issue navigator. Find details of navigable issue columns using [Get fields](#api-rest-api-2-field-get).

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec set_issue_navigator_default_columns(Jira.ColumnRequestBody.t(), keyword) :: :ok | :error
  def set_issue_navigator_default_columns(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jira.IssueNavigatorSettings, :set_issue_navigator_default_columns},
      url: "/rest/api/2/settings/columns",
      body: body,
      method: :put,
      request: [
        {"*/*", {Jira.ColumnRequestBody, :t}},
        {"multipart/form-data", {Jira.ColumnRequestBody, :t}}
      ],
      response: [{200, :null}, {400, :null}, {401, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end
end
