defmodule Jirex.ProjectKeyAndNameValidation do
  @moduledoc """
  Provides API endpoints related to project key and name validation
  """

  @default_client Jirex.Client

  @doc """
  Get valid project key

  Validates a project key and, if the key is invalid or in use, generates a valid random string for the project key.

  **[Permissions](#permissions) required:** None.

  ## Options

    * `key`: The project key.

  """
  @spec get_valid_project_key(keyword) :: {:ok, String.t()} | :error
  def get_valid_project_key(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:key])

    client.request(%{
      args: [],
      call: {Jirex.ProjectKeyAndNameValidation, :get_valid_project_key},
      url: "/rest/api/2/projectvalidate/validProjectKey",
      method: :get,
      query: query,
      response: [{200, {:string, :generic}}, {401, :null}],
      opts: opts
    })
  end

  @doc """
  Get valid project name

  Checks that a project name isn't in use. If the name isn't in use, the passed string is returned. If the name is in use, this operation attempts to generate a valid project name based on the one supplied, usually by adding a sequence number. If a valid project name cannot be generated, a 404 response is returned.

  **[Permissions](#permissions) required:** None.

  ## Options

    * `name`: The project name.

  """
  @spec get_valid_project_name(keyword) :: {:ok, String.t()} | :error
  def get_valid_project_name(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:name])

    client.request(%{
      args: [],
      call: {Jirex.ProjectKeyAndNameValidation, :get_valid_project_name},
      url: "/rest/api/2/projectvalidate/validProjectName",
      method: :get,
      query: query,
      response: [{200, {:string, :generic}}, {400, :null}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Validate project key

  Validates a project key by confirming the key is a valid string and not in use.

  **[Permissions](#permissions) required:** None.

  ## Options

    * `key`: The project key.

  """
  @spec validate_project_key(keyword) :: {:ok, Jirex.ErrorCollection.t()} | :error
  def validate_project_key(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:key])

    client.request(%{
      args: [],
      call: {Jirex.ProjectKeyAndNameValidation, :validate_project_key},
      url: "/rest/api/2/projectvalidate/key",
      method: :get,
      query: query,
      response: [{200, {Jirex.ErrorCollection, :t}}, {401, :null}],
      opts: opts
    })
  end
end
