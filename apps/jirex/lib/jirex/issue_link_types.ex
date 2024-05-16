defmodule Jirex.IssueLinkTypes do
  @moduledoc """
  Provides API endpoints related to issue link types
  """

  @default_client Jirex.Client

  @doc """
  Create issue link type

  Creates an issue link type. Use this operation to create descriptions of the reasons why issues are linked. The issue link type consists of a name and descriptions for a link's inward and outward relationships.

  To use this operation, the site must have [issue linking](https://confluence.atlassian.com/x/yoXKM) enabled.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec create_issue_link_type(Jirex.IssueLinkType.t(), keyword) ::
          {:ok, Jirex.IssueLinkType.t()} | :error
  def create_issue_link_type(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jirex.IssueLinkTypes, :create_issue_link_type},
      url: "/rest/api/2/issueLinkType",
      body: body,
      method: :post,
      request: [{"application/json", {Jirex.IssueLinkType, :t}}],
      response: [{201, {Jirex.IssueLinkType, :t}}, {400, :null}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Delete issue link type

  Deletes an issue link type.

  To use this operation, the site must have [issue linking](https://confluence.atlassian.com/x/yoXKM) enabled.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec delete_issue_link_type(String.t(), keyword) :: :ok | :error
  def delete_issue_link_type(issueLinkTypeId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [issueLinkTypeId: issueLinkTypeId],
      call: {Jirex.IssueLinkTypes, :delete_issue_link_type},
      url: "/rest/api/2/issueLinkType/#{issueLinkTypeId}",
      method: :delete,
      response: [{204, :null}, {400, :null}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get issue link type

  Returns an issue link type.

  To use this operation, the site must have [issue linking](https://confluence.atlassian.com/x/yoXKM) enabled.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for a project in the site.
  """
  @spec get_issue_link_type(String.t(), keyword) :: {:ok, Jirex.IssueLinkType.t()} | :error
  def get_issue_link_type(issueLinkTypeId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [issueLinkTypeId: issueLinkTypeId],
      call: {Jirex.IssueLinkTypes, :get_issue_link_type},
      url: "/rest/api/2/issueLinkType/#{issueLinkTypeId}",
      method: :get,
      response: [{200, {Jirex.IssueLinkType, :t}}, {400, :null}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get issue link types

  Returns a list of all issue link types.

  To use this operation, the site must have [issue linking](https://confluence.atlassian.com/x/yoXKM) enabled.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for a project in the site.
  """
  @spec get_issue_link_types(keyword) :: {:ok, map} | :error
  def get_issue_link_types(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Jirex.IssueLinkTypes, :get_issue_link_types},
      url: "/rest/api/2/issueLinkType",
      method: :get,
      response: [{200, {Jirex.IssueLinkTypes, :t}}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Update issue link type

  Updates an issue link type.

  To use this operation, the site must have [issue linking](https://confluence.atlassian.com/x/yoXKM) enabled.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec update_issue_link_type(String.t(), Jirex.IssueLinkType.t(), keyword) ::
          {:ok, Jirex.IssueLinkType.t()} | :error
  def update_issue_link_type(issueLinkTypeId, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [issueLinkTypeId: issueLinkTypeId, body: body],
      call: {Jirex.IssueLinkTypes, :update_issue_link_type},
      url: "/rest/api/2/issueLinkType/#{issueLinkTypeId}",
      body: body,
      method: :put,
      request: [{"application/json", {Jirex.IssueLinkType, :t}}],
      response: [{200, {Jirex.IssueLinkType, :t}}, {400, :null}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @type t :: %__MODULE__{issueLinkTypes: [Jirex.IssueLinkType.t()] | nil}

  defstruct [:issueLinkTypes]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [issueLinkTypes: [{Jirex.IssueLinkType, :t}]]
  end
end
