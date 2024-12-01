defmodule Jirex.IssueCustomFieldContexts do
  @moduledoc """
  Provides API endpoints related to issue custom field contexts
  """

  @default_client Jirex.Client

  @doc """
  Add issue types to context

  Adds issue types to a custom field context, appending the issue types to the issue types list.

  A custom field context without any issue types applies to all issue types. Adding issue types to such a custom field context would result in it applying to only the listed issue types.

  If any of the issue types exists in the custom field context, the operation fails and no issue types are added.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec add_issue_types_to_context(String.t(), integer, Jirex.IssueTypeIds.t(), keyword) ::
          {:ok, map} | {:error, any}
  def add_issue_types_to_context(fieldId, contextId, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [fieldId: fieldId, contextId: contextId, body: body],
      call: {Jirex.IssueCustomFieldContexts, :add_issue_types_to_context},
      url: "/rest/api/2/field/#{fieldId}/context/#{contextId}/issuetype",
      body: body,
      method: :put,
      request: [{"application/json", {Jirex.IssueTypeIds, :t}}],
      response: [
        {204, :map},
        {400, :unknown},
        {401, :null},
        {403, :unknown},
        {404, :unknown},
        {409, :unknown}
      ],
      opts: opts
    })
  end

  @doc """
  Assign custom field context to projects

  Assigns a custom field context to projects.

  If any project in the request is assigned to any context of the custom field, the operation fails.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec assign_projects_to_custom_field_context(
          String.t(),
          integer,
          Jirex.ProjectIds.t(),
          keyword
        ) :: {:ok, map} | {:error, any}
  def assign_projects_to_custom_field_context(fieldId, contextId, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [fieldId: fieldId, contextId: contextId, body: body],
      call: {Jirex.IssueCustomFieldContexts, :assign_projects_to_custom_field_context},
      url: "/rest/api/2/field/#{fieldId}/context/#{contextId}/project",
      body: body,
      method: :put,
      request: [{"application/json", {Jirex.ProjectIds, :t}}],
      response: [{204, :map}, {400, :unknown}, {401, :null}, {403, :unknown}, {404, :unknown}],
      opts: opts
    })
  end

  @doc """
  Create custom field context

  Creates a custom field context.

  If `projectIds` is empty, a global context is created. A global context is one that applies to all project. If `issueTypeIds` is empty, the context applies to all issue types.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec create_custom_field_context(String.t(), Jirex.CreateCustomFieldContext.t(), keyword) ::
          {:ok, Jirex.CreateCustomFieldContext.t()} | {:error, any}
  def create_custom_field_context(fieldId, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [fieldId: fieldId, body: body],
      call: {Jirex.IssueCustomFieldContexts, :create_custom_field_context},
      url: "/rest/api/2/field/#{fieldId}/context",
      body: body,
      method: :post,
      request: [{"application/json", {Jirex.CreateCustomFieldContext, :t}}],
      response: [
        {201, {Jirex.CreateCustomFieldContext, :t}},
        {400, :null},
        {401, :null},
        {404, :null},
        {409, :unknown}
      ],
      opts: opts
    })
  end

  @doc """
  Delete custom field context

  Deletes a [ custom field context](https://confluence.atlassian.com/adminjiracloud/what-are-custom-field-contexts-991923859.html).

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec delete_custom_field_context(String.t(), integer, keyword) :: {:ok, map} | {:error, any}
  def delete_custom_field_context(fieldId, contextId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [fieldId: fieldId, contextId: contextId],
      call: {Jirex.IssueCustomFieldContexts, :delete_custom_field_context},
      url: "/rest/api/2/field/#{fieldId}/context/#{contextId}",
      method: :delete,
      response: [{204, :map}, {400, :unknown}, {401, :null}, {403, :unknown}, {404, :unknown}],
      opts: opts
    })
  end

  @doc """
  Get custom field contexts

  Returns a [paginated](#pagination) list of [ contexts](https://confluence.atlassian.com/adminjiracloud/what-are-custom-field-contexts-991923859.html) for a custom field. Contexts can be returned as follows:

   *  With no other parameters set, all contexts.
   *  By defining `id` only, all contexts from the list of IDs.
   *  By defining `isAnyIssueType`, limit the list of contexts returned to either those that apply to all issue types (true) or those that apply to only a subset of issue types (false)
   *  By defining `isGlobalContext`, limit the list of contexts return to either those that apply to all projects (global contexts) (true) or those that apply to only a subset of projects (false).

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `isAnyIssueType`: Whether to return contexts that apply to all issue types.
    * `isGlobalContext`: Whether to return contexts that apply to all projects.
    * `contextId`: The list of context IDs. To include multiple contexts, separate IDs with ampersand: `contextId=10000&contextId=10001`.
    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.

  """
  @spec get_contexts_for_field(String.t(), keyword) ::
          {:ok, Jirex.PageBeanCustomFieldContext.t()} | {:error, any}
  def get_contexts_for_field(fieldId, opts \\ []) do
    client = opts[:client] || @default_client

    query =
      Keyword.take(opts, [:contextId, :isAnyIssueType, :isGlobalContext, :maxResults, :startAt])

    client.request(%{
      args: [fieldId: fieldId],
      call: {Jirex.IssueCustomFieldContexts, :get_contexts_for_field},
      url: "/rest/api/2/field/#{fieldId}/context",
      method: :get,
      query: query,
      response: [
        {200, {Jirex.PageBeanCustomFieldContext, :t}},
        {401, :null},
        {403, :unknown},
        {404, :unknown}
      ],
      opts: opts
    })
  end

  @doc """
  Get custom field contexts for projects and issue types

  Returns a [paginated](#pagination) list of project and issue type mappings and, for each mapping, the ID of a [custom field context](https://confluence.atlassian.com/x/k44fOw) that applies to the project and issue type.

  If there is no custom field context assigned to the project then, if present, the custom field context that applies to all projects is returned if it also applies to the issue type or all issue types. If a custom field context is not found, the returned custom field context ID is `null`.

  Duplicate project and issue type mappings cannot be provided in the request.

  The order of the returned values is the same as provided in the request.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.

  """
  @spec get_custom_field_contexts_for_projects_and_issue_types(
          String.t(),
          Jirex.ProjectIssueTypeMappings.t(),
          keyword
        ) :: {:ok, Jirex.PageBeanContextForProjectAndIssueType.t()} | {:error, any}
  def get_custom_field_contexts_for_projects_and_issue_types(fieldId, body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:maxResults, :startAt])

    client.request(%{
      args: [fieldId: fieldId, body: body],
      call:
        {Jirex.IssueCustomFieldContexts, :get_custom_field_contexts_for_projects_and_issue_types},
      url: "/rest/api/2/field/#{fieldId}/context/mapping",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Jirex.ProjectIssueTypeMappings, :t}}],
      response: [
        {200, {Jirex.PageBeanContextForProjectAndIssueType, :t}},
        {400, :unknown},
        {401, :null},
        {403, :unknown},
        {404, :unknown}
      ],
      opts: opts
    })
  end

  @doc """
  Get custom field contexts default values

  Returns a [paginated](#pagination) list of defaults for a custom field. The results can be filtered by `contextId`, otherwise all values are returned. If no defaults are set for a context, nothing is returned.
  The returned object depends on type of the custom field:

   *  `CustomFieldContextDefaultValueDate` (type `datepicker`) for date fields.
   *  `CustomFieldContextDefaultValueDateTime` (type `datetimepicker`) for date-time fields.
   *  `CustomFieldContextDefaultValueSingleOption` (type `option.single`) for single choice select lists and radio buttons.
   *  `CustomFieldContextDefaultValueMultipleOption` (type `option.multiple`) for multiple choice select lists and checkboxes.
   *  `CustomFieldContextDefaultValueCascadingOption` (type `option.cascading`) for cascading select lists.
   *  `CustomFieldContextSingleUserPickerDefaults` (type `single.user.select`) for single users.
   *  `CustomFieldContextDefaultValueMultiUserPicker` (type `multi.user.select`) for user lists.
   *  `CustomFieldContextDefaultValueSingleGroupPicker` (type `grouppicker.single`) for single choice group pickers.
   *  `CustomFieldContextDefaultValueMultipleGroupPicker` (type `grouppicker.multiple`) for multiple choice group pickers.
   *  `CustomFieldContextDefaultValueURL` (type `url`) for URLs.
   *  `CustomFieldContextDefaultValueProject` (type `project`) for project pickers.
   *  `CustomFieldContextDefaultValueFloat` (type `float`) for floats (floating-point numbers).
   *  `CustomFieldContextDefaultValueLabels` (type `labels`) for labels.
   *  `CustomFieldContextDefaultValueTextField` (type `textfield`) for text fields.
   *  `CustomFieldContextDefaultValueTextArea` (type `textarea`) for text area fields.
   *  `CustomFieldContextDefaultValueReadOnly` (type `readonly`) for read only (text) fields.
   *  `CustomFieldContextDefaultValueMultipleVersion` (type `version.multiple`) for single choice version pickers.
   *  `CustomFieldContextDefaultValueSingleVersion` (type `version.single`) for multiple choice version pickers.

  Forge custom fields [types](https://developer.atlassian.com/platform/forge/manifest-reference/modules/jira-custom-field-type/#data-types) are also supported, returning:

   *  `CustomFieldContextDefaultValueForgeStringFieldBean` (type `forge.string`) for Forge string fields.
   *  `CustomFieldContextDefaultValueForgeMultiStringFieldBean` (type `forge.string.list`) for Forge string collection fields.
   *  `CustomFieldContextDefaultValueForgeObjectFieldBean` (type `forge.object`) for Forge object fields.
   *  `CustomFieldContextDefaultValueForgeDateTimeFieldBean` (type `forge.datetime`) for Forge date-time fields.
   *  `CustomFieldContextDefaultValueForgeGroupFieldBean` (type `forge.group`) for Forge group fields.
   *  `CustomFieldContextDefaultValueForgeMultiGroupFieldBean` (type `forge.group.list`) for Forge group collection fields.
   *  `CustomFieldContextDefaultValueForgeNumberFieldBean` (type `forge.number`) for Forge number fields.
   *  `CustomFieldContextDefaultValueForgeUserFieldBean` (type `forge.user`) for Forge user fields.
   *  `CustomFieldContextDefaultValueForgeMultiUserFieldBean` (type `forge.user.list`) for Forge user collection fields.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `contextId`: The IDs of the contexts.
    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.

  """
  @spec get_default_values(String.t(), keyword) ::
          {:ok, Jirex.PageBeanCustomFieldContextDefaultValue.t()} | {:error, any}
  def get_default_values(fieldId, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:contextId, :maxResults, :startAt])

    client.request(%{
      args: [fieldId: fieldId],
      call: {Jirex.IssueCustomFieldContexts, :get_default_values},
      url: "/rest/api/2/field/#{fieldId}/context/defaultValue",
      method: :get,
      query: query,
      response: [
        {200, {Jirex.PageBeanCustomFieldContextDefaultValue, :t}},
        {401, :null},
        {403, :unknown},
        {404, :unknown}
      ],
      opts: opts
    })
  end

  @doc """
  Get issue types for custom field context

  Returns a [paginated](#pagination) list of context to issue type mappings for a custom field. Mappings are returned for all contexts or a list of contexts. Mappings are ordered first by context ID and then by issue type ID.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `contextId`: The ID of the context. To include multiple contexts, provide an ampersand-separated list. For example, `contextId=10001&contextId=10002`.
    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.

  """
  @spec get_issue_type_mappings_for_contexts(String.t(), keyword) ::
          {:ok, Jirex.PageBeanIssueTypeToContextMapping.t()} | {:error, any}
  def get_issue_type_mappings_for_contexts(fieldId, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:contextId, :maxResults, :startAt])

    client.request(%{
      args: [fieldId: fieldId],
      call: {Jirex.IssueCustomFieldContexts, :get_issue_type_mappings_for_contexts},
      url: "/rest/api/2/field/#{fieldId}/context/issuetypemapping",
      method: :get,
      query: query,
      response: [
        {200, {Jirex.PageBeanIssueTypeToContextMapping, :t}},
        {401, :null},
        {403, :unknown}
      ],
      opts: opts
    })
  end

  @doc """
  Get project mappings for custom field context

  Returns a [paginated](#pagination) list of context to project mappings for a custom field. The result can be filtered by `contextId`. Otherwise, all mappings are returned. Invalid IDs are ignored.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `contextId`: The list of context IDs. To include multiple context, separate IDs with ampersand: `contextId=10000&contextId=10001`.
    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.

  """
  @spec get_project_context_mapping(String.t(), keyword) ::
          {:ok, Jirex.PageBeanCustomFieldContextProjectMapping.t()} | {:error, any}
  def get_project_context_mapping(fieldId, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:contextId, :maxResults, :startAt])

    client.request(%{
      args: [fieldId: fieldId],
      call: {Jirex.IssueCustomFieldContexts, :get_project_context_mapping},
      url: "/rest/api/2/field/#{fieldId}/context/projectmapping",
      method: :get,
      query: query,
      response: [
        {200, {Jirex.PageBeanCustomFieldContextProjectMapping, :t}},
        {401, :null},
        {403, :unknown},
        {404, :unknown}
      ],
      opts: opts
    })
  end

  @doc """
  Remove custom field context from projects

  Removes a custom field context from projects.

  A custom field context without any projects applies to all projects. Removing all projects from a custom field context would result in it applying to all projects.

  If any project in the request is not assigned to the context, or the operation would result in two global contexts for the field, the operation fails.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec remove_custom_field_context_from_projects(
          String.t(),
          integer,
          Jirex.ProjectIds.t(),
          keyword
        ) :: {:ok, map} | {:error, any}
  def remove_custom_field_context_from_projects(fieldId, contextId, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [fieldId: fieldId, contextId: contextId, body: body],
      call: {Jirex.IssueCustomFieldContexts, :remove_custom_field_context_from_projects},
      url: "/rest/api/2/field/#{fieldId}/context/#{contextId}/project/remove",
      body: body,
      method: :post,
      request: [{"application/json", {Jirex.ProjectIds, :t}}],
      response: [{204, :map}, {400, :unknown}, {401, :null}, {403, :unknown}, {404, :unknown}],
      opts: opts
    })
  end

  @doc """
  Remove issue types from context

  Removes issue types from a custom field context.

  A custom field context without any issue types applies to all issue types.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec remove_issue_types_from_context(String.t(), integer, Jirex.IssueTypeIds.t(), keyword) ::
          {:ok, map} | {:error, any}
  def remove_issue_types_from_context(fieldId, contextId, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [fieldId: fieldId, contextId: contextId, body: body],
      call: {Jirex.IssueCustomFieldContexts, :remove_issue_types_from_context},
      url: "/rest/api/2/field/#{fieldId}/context/#{contextId}/issuetype/remove",
      body: body,
      method: :post,
      request: [{"application/json", {Jirex.IssueTypeIds, :t}}],
      response: [{204, :map}, {400, :unknown}, {401, :null}, {403, :unknown}, {404, :unknown}],
      opts: opts
    })
  end

  @doc """
  Set custom field contexts default values

  Sets default for contexts of a custom field. Default are defined using these objects:

   *  `CustomFieldContextDefaultValueDate` (type `datepicker`) for date fields.
   *  `CustomFieldContextDefaultValueDateTime` (type `datetimepicker`) for date-time fields.
   *  `CustomFieldContextDefaultValueSingleOption` (type `option.single`) for single choice select lists and radio buttons.
   *  `CustomFieldContextDefaultValueMultipleOption` (type `option.multiple`) for multiple choice select lists and checkboxes.
   *  `CustomFieldContextDefaultValueCascadingOption` (type `option.cascading`) for cascading select lists.
   *  `CustomFieldContextSingleUserPickerDefaults` (type `single.user.select`) for single users.
   *  `CustomFieldContextDefaultValueMultiUserPicker` (type `multi.user.select`) for user lists.
   *  `CustomFieldContextDefaultValueSingleGroupPicker` (type `grouppicker.single`) for single choice group pickers.
   *  `CustomFieldContextDefaultValueMultipleGroupPicker` (type `grouppicker.multiple`) for multiple choice group pickers.
   *  `CustomFieldContextDefaultValueURL` (type `url`) for URLs.
   *  `CustomFieldContextDefaultValueProject` (type `project`) for project pickers.
   *  `CustomFieldContextDefaultValueFloat` (type `float`) for floats (floating-point numbers).
   *  `CustomFieldContextDefaultValueLabels` (type `labels`) for labels.
   *  `CustomFieldContextDefaultValueTextField` (type `textfield`) for text fields.
   *  `CustomFieldContextDefaultValueTextArea` (type `textarea`) for text area fields.
   *  `CustomFieldContextDefaultValueReadOnly` (type `readonly`) for read only (text) fields.
   *  `CustomFieldContextDefaultValueMultipleVersion` (type `version.multiple`) for single choice version pickers.
   *  `CustomFieldContextDefaultValueSingleVersion` (type `version.single`) for multiple choice version pickers.

  Forge custom fields [types](https://developer.atlassian.com/platform/forge/manifest-reference/modules/jira-custom-field-type/#data-types) are also supported, returning:

   *  `CustomFieldContextDefaultValueForgeStringFieldBean` (type `forge.string`) for Forge string fields.
   *  `CustomFieldContextDefaultValueForgeMultiStringFieldBean` (type `forge.string.list`) for Forge string collection fields.
   *  `CustomFieldContextDefaultValueForgeObjectFieldBean` (type `forge.object`) for Forge object fields.
   *  `CustomFieldContextDefaultValueForgeDateTimeFieldBean` (type `forge.datetime`) for Forge date-time fields.
   *  `CustomFieldContextDefaultValueForgeGroupFieldBean` (type `forge.group`) for Forge group fields.
   *  `CustomFieldContextDefaultValueForgeMultiGroupFieldBean` (type `forge.group.list`) for Forge group collection fields.
   *  `CustomFieldContextDefaultValueForgeNumberFieldBean` (type `forge.number`) for Forge number fields.
   *  `CustomFieldContextDefaultValueForgeUserFieldBean` (type `forge.user`) for Forge user fields.
   *  `CustomFieldContextDefaultValueForgeMultiUserFieldBean` (type `forge.user.list`) for Forge user collection fields.

  Only one type of default object can be included in a request. To remove a default for a context, set the default parameter to `null`.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec set_default_values(String.t(), Jirex.CustomFieldContextDefaultValueUpdate.t(), keyword) ::
          {:ok, map} | {:error, any}
  def set_default_values(fieldId, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [fieldId: fieldId, body: body],
      call: {Jirex.IssueCustomFieldContexts, :set_default_values},
      url: "/rest/api/2/field/#{fieldId}/context/defaultValue",
      body: body,
      method: :put,
      request: [{"application/json", {Jirex.CustomFieldContextDefaultValueUpdate, :t}}],
      response: [{204, :map}, {400, :unknown}, {401, :null}, {403, :unknown}, {404, :unknown}],
      opts: opts
    })
  end

  @doc """
  Update custom field context

  Updates a [ custom field context](https://confluence.atlassian.com/adminjiracloud/what-are-custom-field-contexts-991923859.html).

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec update_custom_field_context(
          String.t(),
          integer,
          Jirex.CustomFieldContextUpdateDetails.t(),
          keyword
        ) :: {:ok, map} | {:error, any}
  def update_custom_field_context(fieldId, contextId, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [fieldId: fieldId, contextId: contextId, body: body],
      call: {Jirex.IssueCustomFieldContexts, :update_custom_field_context},
      url: "/rest/api/2/field/#{fieldId}/context/#{contextId}",
      body: body,
      method: :put,
      request: [{"application/json", {Jirex.CustomFieldContextUpdateDetails, :t}}],
      response: [{204, :map}, {400, :unknown}, {401, :null}, {403, :unknown}, {404, :unknown}],
      opts: opts
    })
  end
end
