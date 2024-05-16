defmodule Jirex.Labels do
  @moduledoc """
  Provides API endpoint related to labels
  """

  @default_client Jirex.Client

  @doc """
  Get all labels

  Returns a [paginated](#pagination) list of labels.

  ## Options

    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.

  """
  @spec get_all_labels(keyword) :: {:ok, Jirex.PageBeanString.t()} | :error
  def get_all_labels(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:maxResults, :startAt])

    client.request(%{
      args: [],
      call: {Jirex.Labels, :get_all_labels},
      url: "/rest/api/2/label",
      method: :get,
      query: query,
      response: [{200, {Jirex.PageBeanString, :t}}],
      opts: opts
    })
  end
end
