defmodule Jira.IssueCustomFieldOptionsApps do
  @moduledoc """
  Provides API endpoints related to issue custom field options apps
  """

  @default_client Jira.Client

  @doc """
  Create issue field option

  Creates an option for a select list issue field.

  Note that this operation **only works for issue field select list options added by Connect apps**, it cannot be used with issue field select list options created in Jira or using operations from the [Issue custom field options](#api-group-Issue-custom-field-options) resource.

  Each field can have a maximum of 10000 options, and each option can have a maximum of 10000 scopes.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg). Jira permissions are not required for the app providing the field.
  """
  @spec create_issue_field_option(String.t(), Jira.IssueFieldOptionCreateBean.t(), keyword) ::
          {:ok, Jira.IssueFieldOption.t()} | :error
  def create_issue_field_option(fieldKey, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [fieldKey: fieldKey, body: body],
      call: {Jira.IssueCustomFieldOptionsApps, :create_issue_field_option},
      url: "/rest/api/2/field/#{fieldKey}/option",
      body: body,
      method: :post,
      request: [{"application/json", {Jira.IssueFieldOptionCreateBean, :t}}],
      response: [{200, {Jira.IssueFieldOption, :t}}, {400, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Delete issue field option

  Deletes an option from a select list issue field.

  Note that this operation **only works for issue field select list options added by Connect apps**, it cannot be used with issue field select list options created in Jira or using operations from the [Issue custom field options](#api-group-Issue-custom-field-options) resource.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg). Jira permissions are not required for the app providing the field.
  """
  @spec delete_issue_field_option(String.t(), integer, keyword) :: {:ok, map} | :error
  def delete_issue_field_option(fieldKey, optionId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [fieldKey: fieldKey, optionId: optionId],
      call: {Jira.IssueCustomFieldOptionsApps, :delete_issue_field_option},
      url: "/rest/api/2/field/#{fieldKey}/option/#{optionId}",
      method: :delete,
      response: [{204, :map}, {403, :null}, {404, :null}, {409, :null}],
      opts: opts
    })
  end

  @doc """
  Get all issue field options

  Returns a [paginated](#pagination) list of all the options of a select list issue field. A select list issue field is a type of [issue field](https://developer.atlassian.com/cloud/jira/platform/modules/issue-field/) that enables a user to select a value from a list of options.

  Note that this operation **only works for issue field select list options added by Connect apps**, it cannot be used with issue field select list options created in Jira or using operations from the [Issue custom field options](#api-group-Issue-custom-field-options) resource.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg). Jira permissions are not required for the app providing the field.

  ## Options

    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.

  """
  @spec get_all_issue_field_options(String.t(), keyword) ::
          {:ok, Jira.PageBeanIssueFieldOption.t()} | :error
  def get_all_issue_field_options(fieldKey, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:maxResults, :startAt])

    client.request(%{
      args: [fieldKey: fieldKey],
      call: {Jira.IssueCustomFieldOptionsApps, :get_all_issue_field_options},
      url: "/rest/api/2/field/#{fieldKey}/option",
      method: :get,
      query: query,
      response: [{200, {Jira.PageBeanIssueFieldOption, :t}}, {400, :null}, {403, :null}],
      opts: opts
    })
  end

  @doc """
  Get issue field option

  Returns an option from a select list issue field.

  Note that this operation **only works for issue field select list options added by Connect apps**, it cannot be used with issue field select list options created in Jira or using operations from the [Issue custom field options](#api-group-Issue-custom-field-options) resource.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg). Jira permissions are not required for the app providing the field.
  """
  @spec get_issue_field_option(String.t(), integer, keyword) ::
          {:ok, Jira.IssueFieldOption.t()} | :error
  def get_issue_field_option(fieldKey, optionId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [fieldKey: fieldKey, optionId: optionId],
      call: {Jira.IssueCustomFieldOptionsApps, :get_issue_field_option},
      url: "/rest/api/2/field/#{fieldKey}/option/#{optionId}",
      method: :get,
      response: [{200, {Jira.IssueFieldOption, :t}}, {400, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get selectable issue field options

  Returns a [paginated](#pagination) list of options for a select list issue field that can be viewed and selected by the user.

  Note that this operation **only works for issue field select list options added by Connect apps**, it cannot be used with issue field select list options created in Jira or using operations from the [Issue custom field options](#api-group-Issue-custom-field-options) resource.

  **[Permissions](#permissions) required:** Permission to access Jira.

  ## Options

    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.
    * `projectId`: Filters the results to options that are only available in the specified project.

  """
  @spec get_selectable_issue_field_options(String.t(), keyword) ::
          {:ok, Jira.PageBeanIssueFieldOption.t()} | :error
  def get_selectable_issue_field_options(fieldKey, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:maxResults, :projectId, :startAt])

    client.request(%{
      args: [fieldKey: fieldKey],
      call: {Jira.IssueCustomFieldOptionsApps, :get_selectable_issue_field_options},
      url: "/rest/api/2/field/#{fieldKey}/option/suggestions/edit",
      method: :get,
      query: query,
      response: [{200, {Jira.PageBeanIssueFieldOption, :t}}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get visible issue field options

  Returns a [paginated](#pagination) list of options for a select list issue field that can be viewed by the user.

  Note that this operation **only works for issue field select list options added by Connect apps**, it cannot be used with issue field select list options created in Jira or using operations from the [Issue custom field options](#api-group-Issue-custom-field-options) resource.

  **[Permissions](#permissions) required:** Permission to access Jira.

  ## Options

    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.
    * `projectId`: Filters the results to options that are only available in the specified project.

  """
  @spec get_visible_issue_field_options(String.t(), keyword) ::
          {:ok, Jira.PageBeanIssueFieldOption.t()} | :error
  def get_visible_issue_field_options(fieldKey, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:maxResults, :projectId, :startAt])

    client.request(%{
      args: [fieldKey: fieldKey],
      call: {Jira.IssueCustomFieldOptionsApps, :get_visible_issue_field_options},
      url: "/rest/api/2/field/#{fieldKey}/option/suggestions/search",
      method: :get,
      query: query,
      response: [{200, {Jira.PageBeanIssueFieldOption, :t}}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Replace issue field option

  Deselects an issue-field select-list option from all issues where it is selected. A different option can be selected to replace the deselected option. The update can also be limited to a smaller set of issues by using a JQL query.

  Connect and Forge app users with *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg) can override the screen security configuration using `overrideScreenSecurity` and `overrideEditableFlag`.

  This is an [asynchronous operation](#async). The response object contains a link to the long-running task.

  Note that this operation **only works for issue field select list options added by Connect apps**, it cannot be used with issue field select list options created in Jira or using operations from the [Issue custom field options](#api-group-Issue-custom-field-options) resource.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg). Jira permissions are not required for the app providing the field.

  ## Options

    * `replaceWith`: The ID of the option that will replace the currently selected option.
    * `jql`: A JQL query that specifies the issues to be updated. For example, *project=10000*.
    * `overrideScreenSecurity`: Whether screen security is overridden to enable hidden fields to be edited. Available to Connect and Forge app users with admin permission.
    * `overrideEditableFlag`: Whether screen security is overridden to enable uneditable fields to be edited. Available to Connect and Forge app users with *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  """
  @spec replace_issue_field_option(String.t(), integer, keyword) :: :ok | {:error, any}
  def replace_issue_field_option(fieldKey, optionId, opts \\ []) do
    client = opts[:client] || @default_client

    query =
      Keyword.take(opts, [:jql, :overrideEditableFlag, :overrideScreenSecurity, :replaceWith])

    client.request(%{
      args: [fieldKey: fieldKey, optionId: optionId],
      call: {Jira.IssueCustomFieldOptionsApps, :replace_issue_field_option},
      url: "/rest/api/2/field/#{fieldKey}/option/#{optionId}/issue",
      method: :delete,
      query: query,
      response: [
        {303, {Jira.TaskProgressBeanRemoveOptionFromIssuesResult, :t}},
        {400, :null},
        {403, :unknown},
        {404, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Update issue field option

  Updates or creates an option for a select list issue field. This operation requires that the option ID is provided when creating an option, therefore, the option ID needs to be specified as a path and body parameter. The option ID provided in the path and body must be identical.

  Note that this operation **only works for issue field select list options added by Connect apps**, it cannot be used with issue field select list options created in Jira or using operations from the [Issue custom field options](#api-group-Issue-custom-field-options) resource.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg). Jira permissions are not required for the app providing the field.
  """
  @spec update_issue_field_option(String.t(), integer, Jira.IssueFieldOption.t(), keyword) ::
          {:ok, Jira.IssueFieldOption.t()} | :error
  def update_issue_field_option(fieldKey, optionId, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [fieldKey: fieldKey, optionId: optionId, body: body],
      call: {Jira.IssueCustomFieldOptionsApps, :update_issue_field_option},
      url: "/rest/api/2/field/#{fieldKey}/option/#{optionId}",
      body: body,
      method: :put,
      request: [{"application/json", {Jira.IssueFieldOption, :t}}],
      response: [{200, {Jira.IssueFieldOption, :t}}, {400, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end
end
