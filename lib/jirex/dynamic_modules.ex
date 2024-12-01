defmodule Jirex.DynamicModules do
  @moduledoc """
  Provides API endpoints related to dynamic modules
  """

  @default_client Jirex.Client

  @doc """
  Get modules

  Returns all modules registered dynamically by the calling app.

  **[Permissions](#permissions) required:** Only Connect apps can make this request.
  """
  @spec dynamic_modules_resource_get_modules_get(keyword) ::
          {:ok, Jirex.ConnectModules.t()} | {:error, Jirex.ErrorMessage.t()}
  def dynamic_modules_resource_get_modules_get(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Jirex.DynamicModules, :dynamic_modules_resource_get_modules_get},
      url: "/rest/atlassian-connect/1/app/module/dynamic",
      method: :get,
      response: [{200, {Jirex.ConnectModules, :t}}, {401, {Jirex.ErrorMessage, :t}}],
      opts: opts
    })
  end

  @doc """
  Register modules

  Registers a list of modules.

  **[Permissions](#permissions) required:** Only Connect apps can make this request.
  """
  @spec dynamic_modules_resource_register_modules_post(Jirex.ConnectModules.t(), keyword) ::
          :ok | {:error, Jirex.ErrorMessage.t()}
  def dynamic_modules_resource_register_modules_post(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jirex.DynamicModules, :dynamic_modules_resource_register_modules_post},
      url: "/rest/atlassian-connect/1/app/module/dynamic",
      body: body,
      method: :post,
      request: [{"application/json", {Jirex.ConnectModules, :t}}],
      response: [{200, :null}, {400, {Jirex.ErrorMessage, :t}}, {401, {Jirex.ErrorMessage, :t}}],
      opts: opts
    })
  end

  @doc """
  Remove modules

  Remove all or a list of modules registered by the calling app.

  **[Permissions](#permissions) required:** Only Connect apps can make this request.

  ## Options

    * `moduleKey`: The key of the module to remove. To include multiple module keys, provide multiple copies of this parameter.
      For example, `moduleKey=dynamic-attachment-entity-property&moduleKey=dynamic-select-field`.
      Nonexistent keys are ignored.

  """
  @spec dynamic_modules_resource_remove_modules_delete(keyword) ::
          :ok | {:error, Jirex.ErrorMessage.t()}
  def dynamic_modules_resource_remove_modules_delete(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:moduleKey])

    client.request(%{
      args: [],
      call: {Jirex.DynamicModules, :dynamic_modules_resource_remove_modules_delete},
      url: "/rest/atlassian-connect/1/app/module/dynamic",
      method: :delete,
      query: query,
      response: [{204, :null}, {401, {Jirex.ErrorMessage, :t}}],
      opts: opts
    })
  end
end
