defmodule Jira.IssueCustomFieldOptions do
  @moduledoc """
  Provides API endpoints related to issue custom field options
  """

  @default_client Jira.Client

  @doc """
  Create custom field options (context)

  Creates options and, where the custom select field is of the type Select List (cascading), cascading options for a custom select field. The options are added to a context of the field.

  The maximum number of options that can be created per request is 1000 and each field can have a maximum of 10000 options.

  This operation works for custom field options created in Jira or the operations from this resource. **To work with issue field select list options created for Connect apps use the [Issue custom field options (apps)](#api-group-issue-custom-field-options--apps-) operations.**

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec create_custom_field_option(
          String.t(),
          integer,
          Jira.BulkCustomFieldOptionCreateRequest.t(),
          keyword
        ) :: {:ok, Jira.CustomFieldCreatedContextOptionsList.t()} | {:error, any}
  def create_custom_field_option(fieldId, contextId, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [fieldId: fieldId, contextId: contextId, body: body],
      call: {Jira.IssueCustomFieldOptions, :create_custom_field_option},
      url: "/rest/api/2/field/#{fieldId}/context/#{contextId}/option",
      body: body,
      method: :post,
      request: [{"application/json", {Jira.BulkCustomFieldOptionCreateRequest, :t}}],
      response: [
        {200, {Jira.CustomFieldCreatedContextOptionsList, :t}},
        {400, :unknown},
        {401, :null},
        {403, :unknown},
        {404, :unknown}
      ],
      opts: opts
    })
  end

  @doc """
  Delete custom field options (context)

  Deletes a custom field option.

  Options with cascading options cannot be deleted without deleting the cascading options first.

  This operation works for custom field options created in Jira or the operations from this resource. **To work with issue field select list options created for Connect apps use the [Issue custom field options (apps)](#api-group-issue-custom-field-options--apps-) operations.**

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec delete_custom_field_option(String.t(), integer, integer, keyword) :: :ok | {:error, any}
  def delete_custom_field_option(fieldId, contextId, optionId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [fieldId: fieldId, contextId: contextId, optionId: optionId],
      call: {Jira.IssueCustomFieldOptions, :delete_custom_field_option},
      url: "/rest/api/2/field/#{fieldId}/context/#{contextId}/option/#{optionId}",
      method: :delete,
      response: [{204, :null}, {400, :unknown}, {401, :null}, {403, :unknown}, {404, :unknown}],
      opts: opts
    })
  end

  @doc """
  Get custom field option

  Returns a custom field option. For example, an option in a select list.

  Note that this operation **only works for issue field select list options created in Jira or using operations from the [Issue custom field options](#api-group-Issue-custom-field-options) resource**, it cannot be used with issue field select list options created by Connect apps.

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** The custom field option is returned as follows:

   *  if the user has the *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
   *  if the user has the *Browse projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for at least one project the custom field is used in, and the field is visible in at least one layout the user has permission to view.
  """
  @spec get_custom_field_option(String.t(), keyword) :: {:ok, Jira.CustomFieldOption.t()} | :error
  def get_custom_field_option(id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id],
      call: {Jira.IssueCustomFieldOptions, :get_custom_field_option},
      url: "/rest/api/2/customFieldOption/#{id}",
      method: :get,
      response: [{200, {Jira.CustomFieldOption, :t}}, {401, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Get custom field options (context)

  Returns a [paginated](#pagination) list of all custom field option for a context. Options are returned first then cascading options, in the order they display in Jira.

  This operation works for custom field options created in Jira or the operations from this resource. **To work with issue field select list options created for Connect apps use the [Issue custom field options (apps)](#api-group-issue-custom-field-options--apps-) operations.**

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `optionId`: The ID of the option.
    * `onlyOptions`: Whether only options are returned.
    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.

  """
  @spec get_options_for_context(String.t(), integer, keyword) ::
          {:ok, Jira.PageBeanCustomFieldContextOption.t()} | {:error, any}
  def get_options_for_context(fieldId, contextId, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:maxResults, :onlyOptions, :optionId, :startAt])

    client.request(%{
      args: [fieldId: fieldId, contextId: contextId],
      call: {Jira.IssueCustomFieldOptions, :get_options_for_context},
      url: "/rest/api/2/field/#{fieldId}/context/#{contextId}/option",
      method: :get,
      query: query,
      response: [
        {200, {Jira.PageBeanCustomFieldContextOption, :t}},
        {400, :unknown},
        {401, :null},
        {403, :unknown},
        {404, :unknown}
      ],
      opts: opts
    })
  end

  @doc """
  Reorder custom field options (context)

  Changes the order of custom field options or cascading options in a context.

  This operation works for custom field options created in Jira or the operations from this resource. **To work with issue field select list options created for Connect apps use the [Issue custom field options (apps)](#api-group-issue-custom-field-options--apps-) operations.**

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec reorder_custom_field_options(
          String.t(),
          integer,
          Jira.OrderOfCustomFieldOptions.t(),
          keyword
        ) :: {:ok, map} | {:error, any}
  def reorder_custom_field_options(fieldId, contextId, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [fieldId: fieldId, contextId: contextId, body: body],
      call: {Jira.IssueCustomFieldOptions, :reorder_custom_field_options},
      url: "/rest/api/2/field/#{fieldId}/context/#{contextId}/option/move",
      body: body,
      method: :put,
      request: [{"application/json", {Jira.OrderOfCustomFieldOptions, :t}}],
      response: [{204, :map}, {400, :unknown}, {401, :null}, {403, :unknown}, {404, :unknown}],
      opts: opts
    })
  end

  @doc """
  Replace custom field options

  Replaces the options of a custom field.

  Note that this operation **only works for issue field select list options created in Jira or using operations from the [Issue custom field options](#api-group-Issue-custom-field-options) resource**, it cannot be used with issue field select list options created by Connect or Forge apps.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `replaceWith`: The ID of the option that will replace the currently selected option.
    * `jql`: A JQL query that specifies the issues to be updated. For example, *project=10000*.

  """
  @spec replace_custom_field_option(String.t(), integer, integer, keyword) :: :ok | {:error, any}
  def replace_custom_field_option(fieldId, optionId, contextId, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:jql, :replaceWith])

    client.request(%{
      args: [fieldId: fieldId, optionId: optionId, contextId: contextId],
      call: {Jira.IssueCustomFieldOptions, :replace_custom_field_option},
      url: "/rest/api/2/field/#{fieldId}/context/#{contextId}/option/#{optionId}/issue",
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
  Update custom field options (context)

  Updates the options of a custom field.

  If any of the options are not found, no options are updated. Options where the values in the request match the current values aren't updated and aren't reported in the response.

  Note that this operation **only works for issue field select list options created in Jira or using operations from the [Issue custom field options](#api-group-Issue-custom-field-options) resource**, it cannot be used with issue field select list options created by Connect apps.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec update_custom_field_option(
          String.t(),
          integer,
          Jira.BulkCustomFieldOptionUpdateRequest.t(),
          keyword
        ) :: {:ok, Jira.CustomFieldUpdatedContextOptionsList.t()} | {:error, any}
  def update_custom_field_option(fieldId, contextId, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [fieldId: fieldId, contextId: contextId, body: body],
      call: {Jira.IssueCustomFieldOptions, :update_custom_field_option},
      url: "/rest/api/2/field/#{fieldId}/context/#{contextId}/option",
      body: body,
      method: :put,
      request: [{"application/json", {Jira.BulkCustomFieldOptionUpdateRequest, :t}}],
      response: [
        {200, {Jira.CustomFieldUpdatedContextOptionsList, :t}},
        {400, :unknown},
        {401, :null},
        {403, :unknown},
        {404, :unknown}
      ],
      opts: opts
    })
  end
end
