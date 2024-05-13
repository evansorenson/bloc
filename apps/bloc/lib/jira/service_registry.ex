defmodule Jira.ServiceRegistry do
  @moduledoc """
  Provides API endpoint related to service registry
  """

  @default_client Jira.Client

  @doc """
  Retrieve the attributes of service registries

  Retrieve the attributes of given service registries.

  **[Permissions](#permissions) required:** Only Connect apps can make this request and the servicesIds belong to the tenant you are requesting

  ## Options

    * `serviceIds`: The ID of the services (the strings starting with "b:" need to be decoded in Base64).

  """
  @spec service_registry_resource_services_get(keyword) :: {:ok, [map]} | :error
  def service_registry_resource_services_get(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:serviceIds])

    client.request(%{
      args: [],
      call: {Jira.ServiceRegistry, :service_registry_resource_services_get},
      url: "/rest/atlassian-connect/1/service-registry",
      method: :get,
      query: query,
      response: [
        {200, [{Jira.ServiceRegistry, :t}]},
        {400, :null},
        {401, :null},
        {403, :null},
        {500, :null},
        {501, :null},
        {504, :null}
      ],
      opts: opts
    })
  end

  @type t :: %__MODULE__{
          description: String.t() | nil,
          id: String.t() | nil,
          name: String.t() | nil,
          organizationId: String.t() | nil,
          revision: String.t() | nil,
          serviceTier: Jira.ServiceRegistryTier.t() | nil
        }

  defstruct [:description, :id, :name, :organizationId, :revision, :serviceTier]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      description: {:string, :generic},
      id: {:string, :uuid},
      name: {:string, :generic},
      organizationId: {:string, :generic},
      revision: {:string, :generic},
      serviceTier: {Jira.ServiceRegistryTier, :t}
    ]
  end
end
