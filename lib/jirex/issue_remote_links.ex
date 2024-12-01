defmodule Jirex.IssueRemoteLinks do
  @moduledoc """
  Provides API endpoints related to issue remote links
  """

  @default_client Jirex.Client

  @doc """
  Create or update remote issue link

  Creates or updates a remote issue link for an issue.

  If a `globalId` is provided and a remote issue link with that global ID is found it is updated. Any fields without values in the request are set to null. Otherwise, the remote issue link is created.

  This operation requires [issue linking to be active](https://confluence.atlassian.com/x/yoXKM).

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:**

   *  *Browse projects* and *Link issues* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project that the issue is in.
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is configured, issue-level security permission to view the issue.
  """
  @spec create_or_update_remote_issue_link(String.t(), Jirex.RemoteIssueLinkRequest.t(), keyword) ::
          {:ok, Jirex.RemoteIssueLinkIdentifies.t()} | {:error, any}
  def create_or_update_remote_issue_link(issueIdOrKey, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [issueIdOrKey: issueIdOrKey, body: body],
      call: {Jirex.IssueRemoteLinks, :create_or_update_remote_issue_link},
      url: "/rest/api/2/issue/#{issueIdOrKey}/remotelink",
      body: body,
      method: :post,
      request: [{"application/json", {Jirex.RemoteIssueLinkRequest, :t}}],
      response: [
        {200, {Jirex.RemoteIssueLinkIdentifies, :t}},
        {201, {Jirex.RemoteIssueLinkIdentifies, :t}},
        {400, :unknown},
        {401, :null},
        {403, :null},
        {404, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Delete remote issue link by global ID

  Deletes the remote issue link from the issue using the link's global ID. Where the global ID includes reserved URL characters these must be escaped in the request. For example, pass `system=http://www.mycompany.com/support&id=1` as `system%3Dhttp%3A%2F%2Fwww.mycompany.com%2Fsupport%26id%3D1`.

  This operation requires [issue linking to be active](https://confluence.atlassian.com/x/yoXKM).

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:**

   *  *Browse projects* and *Link issues* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project that the issue is in.
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is implemented, issue-level security permission to view the issue.

  ## Options

    * `globalId`: The global ID of a remote issue link.

  """
  @spec delete_remote_issue_link_by_global_id(String.t(), keyword) :: :ok | :error
  def delete_remote_issue_link_by_global_id(issueIdOrKey, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:globalId])

    client.request(%{
      args: [issueIdOrKey: issueIdOrKey],
      call: {Jirex.IssueRemoteLinks, :delete_remote_issue_link_by_global_id},
      url: "/rest/api/2/issue/#{issueIdOrKey}/remotelink",
      method: :delete,
      query: query,
      response: [{204, :null}, {400, :null}, {401, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Delete remote issue link by ID

  Deletes a remote issue link from an issue.

  This operation requires [issue linking to be active](https://confluence.atlassian.com/x/yoXKM).

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:**

   *  *Browse projects*, *Edit issues*, and *Link issues* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project that the issue is in.
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is configured, issue-level security permission to view the issue.
  """
  @spec delete_remote_issue_link_by_id(String.t(), String.t(), keyword) :: :ok | :error
  def delete_remote_issue_link_by_id(issueIdOrKey, linkId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [issueIdOrKey: issueIdOrKey, linkId: linkId],
      call: {Jirex.IssueRemoteLinks, :delete_remote_issue_link_by_id},
      url: "/rest/api/2/issue/#{issueIdOrKey}/remotelink/#{linkId}",
      method: :delete,
      response: [{204, :null}, {400, :null}, {401, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get remote issue link by ID

  Returns a remote issue link for an issue.

  This operation requires [issue linking to be active](https://confluence.atlassian.com/x/yoXKM).

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:**

   *  *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project that the issue is in.
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is configured, issue-level security permission to view the issue.
  """
  @spec get_remote_issue_link_by_id(String.t(), String.t(), keyword) ::
          {:ok, Jirex.RemoteIssueLink.t()} | :error
  def get_remote_issue_link_by_id(issueIdOrKey, linkId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [issueIdOrKey: issueIdOrKey, linkId: linkId],
      call: {Jirex.IssueRemoteLinks, :get_remote_issue_link_by_id},
      url: "/rest/api/2/issue/#{issueIdOrKey}/remotelink/#{linkId}",
      method: :get,
      response: [
        {200, {Jirex.RemoteIssueLink, :t}},
        {400, :null},
        {401, :null},
        {403, :null},
        {404, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Get remote issue links

  Returns the remote issue links for an issue. When a remote issue link global ID is provided the record with that global ID is returned, otherwise all remote issue links are returned. Where a global ID includes reserved URL characters these must be escaped in the request. For example, pass `system=http://www.mycompany.com/support&id=1` as `system%3Dhttp%3A%2F%2Fwww.mycompany.com%2Fsupport%26id%3D1`.

  This operation requires [issue linking to be active](https://confluence.atlassian.com/x/yoXKM).

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:**

   *  *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project that the issue is in.
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is configured, issue-level security permission to view the issue.

  ## Options

    * `globalId`: The global ID of the remote issue link.

  """
  @spec get_remote_issue_links(String.t(), keyword) :: {:ok, Jirex.RemoteIssueLink.t()} | :error
  def get_remote_issue_links(issueIdOrKey, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:globalId])

    client.request(%{
      args: [issueIdOrKey: issueIdOrKey],
      call: {Jirex.IssueRemoteLinks, :get_remote_issue_links},
      url: "/rest/api/2/issue/#{issueIdOrKey}/remotelink",
      method: :get,
      query: query,
      response: [
        {200, {Jirex.RemoteIssueLink, :t}},
        {400, :null},
        {401, :null},
        {403, :null},
        {404, :null},
        {413, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Update remote issue link by ID

  Updates a remote issue link for an issue.

  Note: Fields without values in the request are set to null.

  This operation requires [issue linking to be active](https://confluence.atlassian.com/x/yoXKM).

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:**

   *  *Browse projects* and *Link issues* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project that the issue is in.
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is configured, issue-level security permission to view the issue.
  """
  @spec update_remote_issue_link(
          String.t(),
          String.t(),
          Jirex.RemoteIssueLinkRequest.t(),
          keyword
        ) :: {:ok, map} | {:error, any}
  def update_remote_issue_link(issueIdOrKey, linkId, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [issueIdOrKey: issueIdOrKey, linkId: linkId, body: body],
      call: {Jirex.IssueRemoteLinks, :update_remote_issue_link},
      url: "/rest/api/2/issue/#{issueIdOrKey}/remotelink/#{linkId}",
      body: body,
      method: :put,
      request: [{"application/json", {Jirex.RemoteIssueLinkRequest, :t}}],
      response: [{204, :map}, {400, :unknown}, {401, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end
end
