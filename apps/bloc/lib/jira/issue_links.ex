defmodule Jira.IssueLinks do
  @moduledoc """
  Provides API endpoints related to issue links
  """

  @default_client Jira.Client

  @doc """
  Delete issue link

  Deletes an issue link.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:**

   *  Browse project [project permission](https://confluence.atlassian.com/x/yodKLg) for all the projects containing the issues in the link.
   *  *Link issues* [project permission](https://confluence.atlassian.com/x/yodKLg) for at least one of the projects containing issues in the link.
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is configured, permission to view both of the issues.
  """
  @spec delete_issue_link(String.t(), keyword) :: :ok | :error
  def delete_issue_link(linkId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [linkId: linkId],
      call: {Jira.IssueLinks, :delete_issue_link},
      url: "/rest/api/2/issueLink/#{linkId}",
      method: :delete,
      response: [{200, :null}, {204, :null}, {400, :null}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get issue link

  Returns an issue link.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:**

   *  *Browse project* [project permission](https://confluence.atlassian.com/x/yodKLg) for all the projects containing the linked issues.
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is configured, permission to view both of the issues.
  """
  @spec get_issue_link(String.t(), keyword) :: {:ok, Jira.IssueLink.t()} | :error
  def get_issue_link(linkId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [linkId: linkId],
      call: {Jira.IssueLinks, :get_issue_link},
      url: "/rest/api/2/issueLink/#{linkId}",
      method: :get,
      response: [{200, {Jira.IssueLink, :t}}, {400, :null}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Create issue link

  Creates a link between two issues. Use this operation to indicate a relationship between two issues and optionally add a comment to the from (outward) issue. To use this resource the site must have [Issue Linking](https://confluence.atlassian.com/x/yoXKM) enabled.

  This resource returns nothing on the creation of an issue link. To obtain the ID of the issue link, use `https://your-domain.atlassian.net/rest/api/2/issue/[linked issue key]?fields=issuelinks`.

  If the link request duplicates a link, the response indicates that the issue link was created. If the request included a comment, the comment is added.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:**

   *  *Browse project* [project permission](https://confluence.atlassian.com/x/yodKLg) for all the projects containing the issues to be linked,
   *  *Link issues* [project permission](https://confluence.atlassian.com/x/yodKLg) on the project containing the from (outward) issue,
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is configured, issue-level security permission to view the issue.
   *  If the comment has visibility restrictions, belongs to the group or has the role visibility is restricted to.
  """
  @spec link_issues(Jira.LinkIssueRequestJsonBean.t(), keyword) :: {:ok, map} | :error
  def link_issues(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jira.IssueLinks, :link_issues},
      url: "/rest/api/2/issueLink",
      body: body,
      method: :post,
      request: [{"application/json", {Jira.LinkIssueRequestJsonBean, :t}}],
      response: [{201, :map}, {400, :null}, {401, :null}, {404, :null}, {413, :null}],
      opts: opts
    })
  end
end
