defmodule Jira.IssueVotes do
  @moduledoc """
  Provides API endpoints related to issue votes
  """

  @default_client Jira.Client

  @doc """
  Add vote

  Adds the user's vote to an issue. This is the equivalent of the user clicking *Vote* on an issue in Jira.

  This operation requires the **Allow users to vote on issues** option to be *ON*. This option is set in General configuration for Jira. See [Configuring Jira application options](https://confluence.atlassian.com/x/uYXKM) for details.

  **[Permissions](#permissions) required:**

   *  *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project that the issue is in.
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is configured, issue-level security permission to view the issue.
  """
  @spec add_vote(String.t(), keyword) :: {:ok, map} | :error
  def add_vote(issueIdOrKey, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [issueIdOrKey: issueIdOrKey],
      call: {Jira.IssueVotes, :add_vote},
      url: "/rest/api/2/issue/#{issueIdOrKey}/votes",
      method: :post,
      response: [{204, :map}, {400, :null}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get votes

  Returns details about the votes on an issue.

  This operation requires the **Allow users to vote on issues** option to be *ON*. This option is set in General configuration for Jira. See [Configuring Jira application options](https://confluence.atlassian.com/x/uYXKM) for details.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:**

   *  *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project that the issue is ini
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is configured, issue-level security permission to view the issue.

  Note that users with the necessary permissions for this operation but without the *View voters and watchers* project permissions are not returned details in the `voters` field.
  """
  @spec get_votes(String.t(), keyword) :: {:ok, Jira.Votes.t()} | :error
  def get_votes(issueIdOrKey, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [issueIdOrKey: issueIdOrKey],
      call: {Jira.IssueVotes, :get_votes},
      url: "/rest/api/2/issue/#{issueIdOrKey}/votes",
      method: :get,
      response: [{200, {Jira.Votes, :t}}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Delete vote

  Deletes a user's vote from an issue. This is the equivalent of the user clicking *Unvote* on an issue in Jira.

  This operation requires the **Allow users to vote on issues** option to be *ON*. This option is set in General configuration for Jira. See [Configuring Jira application options](https://confluence.atlassian.com/x/uYXKM) for details.

  **[Permissions](#permissions) required:**

   *  *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project that the issue is in.
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is configured, issue-level security permission to view the issue.
  """
  @spec remove_vote(String.t(), keyword) :: :ok | :error
  def remove_vote(issueIdOrKey, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [issueIdOrKey: issueIdOrKey],
      call: {Jira.IssueVotes, :remove_vote},
      url: "/rest/api/2/issue/#{issueIdOrKey}/votes",
      method: :delete,
      response: [{204, :null}, {401, :null}, {404, :null}],
      opts: opts
    })
  end
end
