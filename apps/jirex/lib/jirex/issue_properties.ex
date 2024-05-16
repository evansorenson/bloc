defmodule Jirex.IssueProperties do
  @moduledoc """
  Provides API endpoints related to issue properties
  """

  @default_client Jirex.Client

  @doc """
  Bulk delete issue property

  Deletes a property value from multiple issues. The issues to be updated can be specified by filter criteria.

  The criteria the filter used to identify eligible issues are:

   *  `entityIds` Only issues from this list are eligible.
   *  `currentValue` Only issues with the property set to this value are eligible.

  If both criteria is specified, they are joined with the logical *AND*: only issues that satisfy both criteria are considered eligible.

  If no filter criteria are specified, all the issues visible to the user and where the user has the EDIT\_ISSUES permission for the issue are considered eligible.

  This operation is:

   *  transactional, either the property is deleted from all eligible issues or, when errors occur, no properties are deleted.
   *  [asynchronous](#async). Follow the `location` link in the response to determine the status of the task and use [Get task](#api-rest-api-2-task-taskId-get) to obtain subsequent updates.

  **[Permissions](#permissions) required:**

   *  *Browse projects* [ project permission](https://confluence.atlassian.com/x/yodKLg) for each project containing issues.
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is configured, issue-level security permission to view the issue.
   *  *Edit issues* [project permission](https://confluence.atlassian.com/x/yodKLg) for each issue.
  """
  @spec bulk_delete_issue_property(
          String.t(),
          Jirex.IssueFilterForBulkPropertyDelete.t(),
          keyword
        ) :: :ok | {:error, Jirex.ErrorCollection.t()}
  def bulk_delete_issue_property(propertyKey, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [propertyKey: propertyKey, body: body],
      call: {Jirex.IssueProperties, :bulk_delete_issue_property},
      url: "/rest/api/2/issue/properties/#{propertyKey}",
      body: body,
      method: :delete,
      request: [{"application/json", {Jirex.IssueFilterForBulkPropertyDelete, :t}}],
      response: [
        {303, :null},
        {400, {Jirex.ErrorCollection, :t}},
        {401, {Jirex.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Bulk set issue properties by issue

  Sets or updates entity property values on issues. Up to 10 entity properties can be specified for each issue and up to 100 issues included in the request.

  The value of the request body must be a [valid](http://tools.ietf.org/html/rfc4627), non-empty JSON.

  This operation is:

   *  [asynchronous](#async). Follow the `location` link in the response to determine the status of the task and use [Get task](#api-rest-api-2-task-taskId-get) to obtain subsequent updates.
   *  non-transactional. Updating some entities may fail. Such information will available in the task result.

  **[Permissions](#permissions) required:**

   *  *Browse projects* and *Edit issues* [project permissions](https://confluence.atlassian.com/x/yodKLg) for the project containing the issue.
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is configured, issue-level security permission to view the issue.
  """
  @spec bulk_set_issue_properties_by_issue(Jirex.MultiIssueEntityProperties.t(), keyword) ::
          :ok | {:error, Jirex.ErrorCollection.t()}
  def bulk_set_issue_properties_by_issue(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jirex.IssueProperties, :bulk_set_issue_properties_by_issue},
      url: "/rest/api/2/issue/properties/multi",
      body: body,
      method: :post,
      request: [{"application/json", {Jirex.MultiIssueEntityProperties, :t}}],
      response: [
        {303, :null},
        {400, {Jirex.ErrorCollection, :t}},
        {401, {Jirex.ErrorCollection, :t}},
        {403, {Jirex.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Bulk set issue property

  Sets a property value on multiple issues.

  The value set can be a constant or determined by a [Jira expression](https://developer.atlassian.com/cloud/jira/platform/jira-expressions/). Expressions must be computable with constant complexity when applied to a set of issues. Expressions must also comply with the [restrictions](https://developer.atlassian.com/cloud/jira/platform/jira-expressions/#restrictions) that apply to all Jira expressions.

  The issues to be updated can be specified by a filter.

  The filter identifies issues eligible for update using these criteria:

   *  `entityIds` Only issues from this list are eligible.
   *  `currentValue` Only issues with the property set to this value are eligible.
   *  `hasProperty`:

       *  If *true*, only issues with the property are eligible.
       *  If *false*, only issues without the property are eligible.

  If more than one criteria is specified, they are joined with the logical *AND*: only issues that satisfy all criteria are eligible.

  If an invalid combination of criteria is provided, an error is returned. For example, specifying a `currentValue` and `hasProperty` as *false* would not match any issues (because without the property the property cannot have a value).

  The filter is optional. Without the filter all the issues visible to the user and where the user has the EDIT\_ISSUES permission for the issue are considered eligible.

  This operation is:

   *  transactional, either all eligible issues are updated or, when errors occur, none are updated.
   *  [asynchronous](#async). Follow the `location` link in the response to determine the status of the task and use [Get task](#api-rest-api-2-task-taskId-get) to obtain subsequent updates.

  **[Permissions](#permissions) required:**

   *  *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for each project containing issues.
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is configured, issue-level security permission to view the issue.
   *  *Edit issues* [project permission](https://confluence.atlassian.com/x/yodKLg) for each issue.
  """
  @spec bulk_set_issue_property(String.t(), Jirex.BulkIssuePropertyUpdateRequest.t(), keyword) ::
          :ok | {:error, Jirex.ErrorCollection.t()}
  def bulk_set_issue_property(propertyKey, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [propertyKey: propertyKey, body: body],
      call: {Jirex.IssueProperties, :bulk_set_issue_property},
      url: "/rest/api/2/issue/properties/#{propertyKey}",
      body: body,
      method: :put,
      request: [{"application/json", {Jirex.BulkIssuePropertyUpdateRequest, :t}}],
      response: [
        {303, :null},
        {400, {Jirex.ErrorCollection, :t}},
        {401, {Jirex.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Bulk set issues properties by list

  Sets or updates a list of entity property values on issues. A list of up to 10 entity properties can be specified along with up to 10,000 issues on which to set or update that list of entity properties.

  The value of the request body must be a [valid](http://tools.ietf.org/html/rfc4627), non-empty JSON. The maximum length of single issue property value is 32768 characters. This operation can be accessed anonymously.

  This operation is:

   *  transactional, either all properties are updated in all eligible issues or, when errors occur, no properties are updated.
   *  [asynchronous](#async). Follow the `location` link in the response to determine the status of the task and use [Get task](#api-rest-api-2-task-taskId-get) to obtain subsequent updates.

  **[Permissions](#permissions) required:**

   *  *Browse projects* and *Edit issues* [project permissions](https://confluence.atlassian.com/x/yodKLg) for the project containing the issue.
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is configured, issue-level security permission to view the issue.
  """
  @spec bulk_set_issues_properties_list(Jirex.IssueEntityProperties.t(), keyword) ::
          :ok | {:error, Jirex.ErrorCollection.t()}
  def bulk_set_issues_properties_list(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jirex.IssueProperties, :bulk_set_issues_properties_list},
      url: "/rest/api/2/issue/properties",
      body: body,
      method: :post,
      request: [{"application/json", {Jirex.IssueEntityProperties, :t}}],
      response: [
        {303, :null},
        {400, {Jirex.ErrorCollection, :t}},
        {401, {Jirex.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Delete issue property

  Deletes an issue's property.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:**

   *  *Browse projects* and *Edit issues* [project permissions](https://confluence.atlassian.com/x/yodKLg) for the project containing the issue.
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is configured, issue-level security permission to view the issue.
  """
  @spec delete_issue_property(String.t(), String.t(), keyword) :: :ok | :error
  def delete_issue_property(issueIdOrKey, propertyKey, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [issueIdOrKey: issueIdOrKey, propertyKey: propertyKey],
      call: {Jirex.IssueProperties, :delete_issue_property},
      url: "/rest/api/2/issue/#{issueIdOrKey}/properties/#{propertyKey}",
      method: :delete,
      response: [{204, :null}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get issue property

  Returns the key and value of an issue's property.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:**

   *  *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project containing the issue.
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is configured, issue-level security permission to view the issue.
  """
  @spec get_issue_property(String.t(), String.t(), keyword) ::
          {:ok, Jirex.EntityProperty.t()} | :error
  def get_issue_property(issueIdOrKey, propertyKey, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [issueIdOrKey: issueIdOrKey, propertyKey: propertyKey],
      call: {Jirex.IssueProperties, :get_issue_property},
      url: "/rest/api/2/issue/#{issueIdOrKey}/properties/#{propertyKey}",
      method: :get,
      response: [{200, {Jirex.EntityProperty, :t}}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get issue property keys

  Returns the URLs and keys of an issue's properties.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** Property details are only returned where the user has:

   *  *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for the project containing the issue.
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is configured, issue-level security permission to view the issue.
  """
  @spec get_issue_property_keys(String.t(), keyword) :: {:ok, Jirex.PropertyKeys.t()} | :error
  def get_issue_property_keys(issueIdOrKey, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [issueIdOrKey: issueIdOrKey],
      call: {Jirex.IssueProperties, :get_issue_property_keys},
      url: "/rest/api/2/issue/#{issueIdOrKey}/properties",
      method: :get,
      response: [{200, {Jirex.PropertyKeys, :t}}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Set issue property

  Sets the value of an issue's property. Use this resource to store custom data against an issue.

  The value of the request body must be a [valid](http://tools.ietf.org/html/rfc4627), non-empty JSON blob. The maximum length is 32768 characters.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:**

   *  *Browse projects* and *Edit issues* [project permissions](https://confluence.atlassian.com/x/yodKLg) for the project containing the issue.
   *  If [issue-level security](https://confluence.atlassian.com/x/J4lKLg) is configured, issue-level security permission to view the issue.
  """
  @spec set_issue_property(String.t(), String.t(), map, keyword) :: {:ok, map} | :error
  def set_issue_property(issueIdOrKey, propertyKey, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [issueIdOrKey: issueIdOrKey, propertyKey: propertyKey, body: body],
      call: {Jirex.IssueProperties, :set_issue_property},
      url: "/rest/api/2/issue/#{issueIdOrKey}/properties/#{propertyKey}",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [{200, :map}, {201, :map}, {400, :null}, {401, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end
end
