defmodule Jirex.IssueSecurityLevel do
  @moduledoc """
  Provides API endpoints related to issue security level
  """

  @default_client Jirex.Client

  @doc """
  Get issue security level

  Returns details of an issue security level.

  Use [Get issue security scheme](#api-rest-api-2-issuesecurityschemes-id-get) to obtain the IDs of issue security levels associated with the issue security scheme.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** None.
  """
  @spec get_issue_security_level(String.t(), keyword) :: {:ok, Jirex.SecurityLevel.t()} | :error
  def get_issue_security_level(id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id],
      call: {Jirex.IssueSecurityLevel, :get_issue_security_level},
      url: "/rest/api/2/securitylevel/#{id}",
      method: :get,
      response: [{200, {Jirex.SecurityLevel, :t}}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get issue security level members by issue security scheme

  Returns issue security level members.

  Only issue security level members in context of classic projects are returned.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.
    * `issueSecurityLevelId`: The list of issue security level IDs. To include multiple issue security levels separate IDs with ampersand: `issueSecurityLevelId=10000&issueSecurityLevelId=10001`.
    * `expand`: Use expand to include additional information in the response. This parameter accepts a comma-separated list. Expand options include:

       *  `all` Returns all expandable information.
       *  `field` Returns information about the custom field granted the permission.
       *  `group` Returns information about the group that is granted the permission.
       *  `projectRole` Returns information about the project role granted the permission.
       *  `user` Returns information about the user who is granted the permission.

  """
  @spec get_issue_security_level_members(integer, keyword) ::
          {:ok, Jirex.PageBeanIssueSecurityLevelMember.t()} | :error
  def get_issue_security_level_members(issueSecuritySchemeId, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:expand, :issueSecurityLevelId, :maxResults, :startAt])

    client.request(%{
      args: [issueSecuritySchemeId: issueSecuritySchemeId],
      call: {Jirex.IssueSecurityLevel, :get_issue_security_level_members},
      url: "/rest/api/2/issuesecurityschemes/#{issueSecuritySchemeId}/members",
      method: :get,
      query: query,
      response: [
        {200, {Jirex.PageBeanIssueSecurityLevelMember, :t}},
        {400, :null},
        {401, :null},
        {403, :null},
        {404, :null}
      ],
      opts: opts
    })
  end
end
