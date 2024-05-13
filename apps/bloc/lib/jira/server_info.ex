defmodule Jira.ServerInfo do
  @moduledoc """
  Provides API endpoint related to server info
  """

  @default_client Jira.Client

  @doc """
  Get Jira instance info

  Returns information about the Jira instance.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** None.
  """
  @spec get_server_info(keyword) :: {:ok, Jira.ServerInformation.t()} | :error
  def get_server_info(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Jira.ServerInfo, :get_server_info},
      url: "/rest/api/2/serverInfo",
      method: :get,
      response: [{200, {Jira.ServerInformation, :t}}, {401, :null}],
      opts: opts
    })
  end
end
