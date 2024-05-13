defmodule Jira.IssueComments do
  @moduledoc """
  Provides API endpoints related to issue comments
  """

  @default_client Jira.Client

  @doc """
  Add comment

  Adds a comment to an issue.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:**

   *  *Browse projects* and *Add comments* [ project permission](https://confluence.atlassian.com/x/yodKLg) for the project that the issue containing the comment is in.
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is configured, issue-level security permission to view the issue.

  ## Options

    * `expand`: Use [expand](#expansion) to include additional information about comments in the response. This parameter accepts `renderedBody`, which returns the comment body rendered in HTML.

  """
  @spec add_comment(String.t(), Jira.Comment.t(), keyword) :: {:ok, Jira.Comment.t()} | :error
  def add_comment(issueIdOrKey, body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:expand])

    client.request(%{
      args: [issueIdOrKey: issueIdOrKey, body: body],
      call: {Jira.IssueComments, :add_comment},
      url: "/rest/api/2/issue/#{issueIdOrKey}/comment",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Jira.Comment, :t}}],
      response: [
        {201, {Jira.Comment, :t}},
        {400, :null},
        {401, :null},
        {404, :null},
        {413, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Delete comment

  Deletes a comment.

  **[Permissions](#permissions) required:**

   *  *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project that the issue containing the comment is in.
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is configured, issue-level security permission to view the issue.
   *  *Delete all comments*[ project permission](https://confluence.atlassian.com/x/yodKLg) to delete any comment or *Delete own comments* to delete comment created by the user,
   *  If the comment has visibility restrictions, the user belongs to the group or has the role visibility is restricted to.
  """
  @spec delete_comment(String.t(), String.t(), keyword) :: :ok | :error
  def delete_comment(issueIdOrKey, id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [issueIdOrKey: issueIdOrKey, id: id],
      call: {Jira.IssueComments, :delete_comment},
      url: "/rest/api/2/issue/#{issueIdOrKey}/comment/#{id}",
      method: :delete,
      response: [{204, :null}, {400, :null}, {401, :null}, {404, :null}, {405, :null}],
      opts: opts
    })
  end

  @doc """
  Get comment

  Returns a comment.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:**

   *  *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project containing the comment.
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is configured, issue-level security permission to view the issue.
   *  If the comment has visibility restrictions, the user belongs to the group or has the role visibility is restricted to.

  ## Options

    * `expand`: Use [expand](#expansion) to include additional information about comments in the response. This parameter accepts `renderedBody`, which returns the comment body rendered in HTML.

  """
  @spec get_comment(String.t(), String.t(), keyword) :: {:ok, Jira.Comment.t()} | :error
  def get_comment(issueIdOrKey, id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:expand])

    client.request(%{
      args: [issueIdOrKey: issueIdOrKey, id: id],
      call: {Jira.IssueComments, :get_comment},
      url: "/rest/api/2/issue/#{issueIdOrKey}/comment/#{id}",
      method: :get,
      query: query,
      response: [{200, {Jira.Comment, :t}}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get comments

  Returns all comments for an issue.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** Comments are included in the response where the user has:

   *  *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project containing the comment.
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is configured, issue-level security permission to view the issue.
   *  If the comment has visibility restrictions, belongs to the group or has the role visibility is role visibility is restricted to.

  ## Options

    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.
    * `orderBy`: [Order](#ordering) the results by a field. Accepts *created* to sort comments by their created date.
    * `expand`: Use [expand](#expansion) to include additional information about comments in the response. This parameter accepts `renderedBody`, which returns the comment body rendered in HTML.

  """
  @spec get_comments(String.t(), keyword) :: {:ok, Jira.PageOfComments.t()} | :error
  def get_comments(issueIdOrKey, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:expand, :maxResults, :orderBy, :startAt])

    client.request(%{
      args: [issueIdOrKey: issueIdOrKey],
      call: {Jira.IssueComments, :get_comments},
      url: "/rest/api/2/issue/#{issueIdOrKey}/comment",
      method: :get,
      query: query,
      response: [{200, {Jira.PageOfComments, :t}}, {400, :null}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get comments by IDs

  Returns a [paginated](#pagination) list of comments specified by a list of comment IDs.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** Comments are returned where the user:

   *  has *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project containing the comment.
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is configured, issue-level security permission to view the issue.
   *  If the comment has visibility restrictions, belongs to the group or has the role visibility is restricted to.

  ## Options

    * `expand`: Use [expand](#expansion) to include additional information about comments in the response. This parameter accepts a comma-separated list. Expand options include:
      
       *  `renderedBody` Returns the comment body rendered in HTML.
       *  `properties` Returns the comment's properties.

  """
  @spec get_comments_by_ids(Jira.IssueCommentListRequestBean.t(), keyword) ::
          {:ok, Jira.PageBeanComment.t()} | :error
  def get_comments_by_ids(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:expand])

    client.request(%{
      args: [body: body],
      call: {Jira.IssueComments, :get_comments_by_ids},
      url: "/rest/api/2/comment/list",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Jira.IssueCommentListRequestBean, :t}}],
      response: [{200, {Jira.PageBeanComment, :t}}, {400, :null}],
      opts: opts
    })
  end

  @doc """
  Update comment

  Updates a comment.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:**

   *  *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project that the issue containing the comment is in.
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is configured, issue-level security permission to view the issue.
   *  *Edit all comments*[ project permission](https://confluence.atlassian.com/x/yodKLg) to update any comment or *Edit own comments* to update comment created by the user.
   *  If the comment has visibility restrictions, the user belongs to the group or has the role visibility is restricted to.

  ## Options

    * `notifyUsers`: Whether users are notified when a comment is updated.
    * `overrideEditableFlag`: Whether screen security is overridden to enable uneditable fields to be edited. Available to Connect app users with the *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg) and Forge apps acting on behalf of users with *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
    * `expand`: Use [expand](#expansion) to include additional information about comments in the response. This parameter accepts `renderedBody`, which returns the comment body rendered in HTML.

  """
  @spec update_comment(String.t(), String.t(), Jira.Comment.t(), keyword) ::
          {:ok, Jira.Comment.t()} | :error
  def update_comment(issueIdOrKey, id, body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:expand, :notifyUsers, :overrideEditableFlag])

    client.request(%{
      args: [issueIdOrKey: issueIdOrKey, id: id, body: body],
      call: {Jira.IssueComments, :update_comment},
      url: "/rest/api/2/issue/#{issueIdOrKey}/comment/#{id}",
      body: body,
      method: :put,
      query: query,
      request: [{"application/json", {Jira.Comment, :t}}],
      response: [{200, {Jira.Comment, :t}}, {400, :null}, {401, :null}, {404, :null}],
      opts: opts
    })
  end
end
