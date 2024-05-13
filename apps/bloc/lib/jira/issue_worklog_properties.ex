defmodule Jira.IssueWorklogProperties do
  @moduledoc """
  Provides API endpoints related to issue worklog properties
  """

  @default_client Jira.Client

  @doc """
  Delete worklog property

  Deletes a worklog property.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:**

   *  *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project that the issue is in.
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is configured, issue-level security permission to view the issue.
   *  If the worklog has visibility restrictions, belongs to the group or has the role visibility is restricted to.
  """
  @spec delete_worklog_property(String.t(), String.t(), String.t(), keyword) :: :ok | :error
  def delete_worklog_property(issueIdOrKey, worklogId, propertyKey, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [issueIdOrKey: issueIdOrKey, worklogId: worklogId, propertyKey: propertyKey],
      call: {Jira.IssueWorklogProperties, :delete_worklog_property},
      url: "/rest/api/2/issue/#{issueIdOrKey}/worklog/#{worklogId}/properties/#{propertyKey}",
      method: :delete,
      response: [{204, :null}, {400, :null}, {401, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get worklog property

  Returns the value of a worklog property.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:**

   *  *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project that the issue is in.
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is configured, issue-level security permission to view the issue.
   *  If the worklog has visibility restrictions, belongs to the group or has the role visibility is restricted to.
  """
  @spec get_worklog_property(String.t(), String.t(), String.t(), keyword) ::
          {:ok, Jira.EntityProperty.t()} | :error
  def get_worklog_property(issueIdOrKey, worklogId, propertyKey, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [issueIdOrKey: issueIdOrKey, worklogId: worklogId, propertyKey: propertyKey],
      call: {Jira.IssueWorklogProperties, :get_worklog_property},
      url: "/rest/api/2/issue/#{issueIdOrKey}/worklog/#{worklogId}/properties/#{propertyKey}",
      method: :get,
      response: [{200, {Jira.EntityProperty, :t}}, {400, :null}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get worklog property keys

  Returns the keys of all properties for a worklog.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:**

   *  *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project that the issue is in.
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is configured, issue-level security permission to view the issue.
   *  If the worklog has visibility restrictions, belongs to the group or has the role visibility is restricted to.
  """
  @spec get_worklog_property_keys(String.t(), String.t(), keyword) ::
          {:ok, Jira.PropertyKeys.t()} | :error
  def get_worklog_property_keys(issueIdOrKey, worklogId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [issueIdOrKey: issueIdOrKey, worklogId: worklogId],
      call: {Jira.IssueWorklogProperties, :get_worklog_property_keys},
      url: "/rest/api/2/issue/#{issueIdOrKey}/worklog/#{worklogId}/properties",
      method: :get,
      response: [{200, {Jira.PropertyKeys, :t}}, {400, :null}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Set worklog property

  Sets the value of a worklog property. Use this operation to store custom data against the worklog.

  The value of the request body must be a [valid](http://tools.ietf.org/html/rfc4627), non-empty JSON blob. The maximum length is 32768 characters.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:**

   *  *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project that the issue is in.
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is configured, issue-level security permission to view the issue.
   *  *Edit all worklogs*[ project permission](https://confluence.atlassian.com/x/yodKLg) to update any worklog or *Edit own worklogs* to update worklogs created by the user.
   *  If the worklog has visibility restrictions, belongs to the group or has the role visibility is restricted to.
  """
  @spec set_worklog_property(String.t(), String.t(), String.t(), map, keyword) ::
          {:ok, map} | :error
  def set_worklog_property(issueIdOrKey, worklogId, propertyKey, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [
        issueIdOrKey: issueIdOrKey,
        worklogId: worklogId,
        propertyKey: propertyKey,
        body: body
      ],
      call: {Jira.IssueWorklogProperties, :set_worklog_property},
      url: "/rest/api/2/issue/#{issueIdOrKey}/worklog/#{worklogId}/properties/#{propertyKey}",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [{200, :map}, {201, :map}, {400, :null}, {401, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end
end
