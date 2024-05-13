defmodule Jira.ClassificationLevels do
  @moduledoc """
  Provides API endpoint related to classification levels
  """

  @default_client Jira.Client

  @doc """
  Get all classification levels

  Returns all classification levels.

  **[Permissions](#permissions) required:** None.

  ## Options

    * `status`: Optional set of statuses to filter by.
    * `orderBy`: Ordering of the results by a given field. If not provided, values will not be sorted.

  """
  @spec get_all_user_data_classification_levels(keyword) ::
          {:ok, Jira.DataClassificationLevelsBean.t()} | :error
  def get_all_user_data_classification_levels(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:orderBy, :status])

    client.request(%{
      args: [],
      call: {Jira.ClassificationLevels, :get_all_user_data_classification_levels},
      url: "/rest/api/2/classification-levels",
      method: :get,
      query: query,
      response: [{200, {Jira.DataClassificationLevelsBean, :t}}, {401, :null}],
      opts: opts
    })
  end
end
