defmodule Jirex.IssueFields do
  @moduledoc """
  Provides API endpoints related to issue fields
  """

  @default_client Jirex.Client

  @doc """
  Create custom field

  Creates a custom field.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec create_custom_field(Jirex.CustomFieldDefinitionJsonBean.t(), keyword) ::
          {:ok, Jirex.FieldDetails.t()} | :error
  def create_custom_field(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jirex.IssueFields, :create_custom_field},
      url: "/rest/api/2/field",
      body: body,
      method: :post,
      request: [{"application/json", {Jirex.CustomFieldDefinitionJsonBean, :t}}],
      response: [{201, {Jirex.FieldDetails, :t}}, {400, :null}],
      opts: opts
    })
  end

  @doc """
  Delete custom field

  Deletes a custom field. The custom field is deleted whether it is in the trash or not. See [Edit or delete a custom field](https://confluence.atlassian.com/x/Z44fOw) for more information on trashing and deleting custom fields.

  This operation is [asynchronous](#async). Follow the `location` link in the response to determine the status of the task and use [Get task](#api-rest-api-2-task-taskId-get) to obtain subsequent updates.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec delete_custom_field(String.t(), keyword) :: :ok | {:error, Jirex.ErrorCollection.t()}
  def delete_custom_field(id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id],
      call: {Jirex.IssueFields, :delete_custom_field},
      url: "/rest/api/2/field/#{id}",
      method: :delete,
      response: [
        {303, {Jirex.TaskProgressBeanObject, :t}},
        {400, {Jirex.ErrorCollection, :t}},
        {401, {Jirex.ErrorCollection, :t}},
        {403, {Jirex.ErrorCollection, :t}},
        {404, {Jirex.ErrorCollection, :t}},
        {409, {Jirex.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get contexts for a field

  Returns a [paginated](#pagination) list of the contexts a field is used in. Deprecated, use [ Get custom field contexts](#api-rest-api-2-field-fieldId-context-get).

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.

  """
  @spec get_contexts_for_field_deprecated(String.t(), keyword) ::
          {:ok, Jirex.PageBeanContext.t()} | :error
  def get_contexts_for_field_deprecated(fieldId, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:maxResults, :startAt])

    client.request(%{
      args: [fieldId: fieldId],
      call: {Jirex.IssueFields, :get_contexts_for_field_deprecated},
      url: "/rest/api/2/field/#{fieldId}/contexts",
      method: :get,
      query: query,
      response: [{200, {Jirex.PageBeanContext, :t}}, {401, :null}, {403, :null}],
      opts: opts
    })
  end

  @doc """
  Get fields

  Returns system and custom issue fields according to the following rules:

   *  Fields that cannot be added to the issue navigator are always returned.
   *  Fields that cannot be placed on an issue screen are always returned.
   *  Fields that depend on global Jira settings are only returned if the setting is enabled. That is, timetracking fields, subtasks, votes, and watches.
   *  For all other fields, this operation only returns the fields that the user has permission to view (that is, the field is used in at least one project that the user has *Browse Projects* [project permission](https://confluence.atlassian.com/x/yodKLg) for.)

  This operation can be accessed anonymously.

  **[Permissions](#permissions) required:** None.
  """
  @spec get_fields(keyword) :: {:ok, [Jirex.FieldDetails.t()]} | :error
  def get_fields(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Jirex.IssueFields, :get_fields},
      url: "/rest/api/2/field",
      method: :get,
      response: [{200, [{Jirex.FieldDetails, :t}]}, {401, :null}],
      opts: opts
    })
  end

  @doc """
  Get fields paginated

  Returns a [paginated](#pagination) list of fields for Classic Jira projects. The list can include:

   *  all fields
   *  specific fields, by defining `id`
   *  fields that contain a string in the field name or description, by defining `query`
   *  specific fields that contain a string in the field name or description, by defining `id` and `query`

  Only custom fields can be queried, `type` must be set to `custom`.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.
    * `type`: The type of fields to search.
    * `id`: The IDs of the custom fields to return or, where `query` is specified, filter.
    * `query`: String used to perform a case-insensitive partial match with field names or descriptions.
    * `orderBy`: [Order](#ordering) the results by a field:

       *  `contextsCount` sorts by the number of contexts related to a field
       *  `lastUsed` sorts by the date when the value of the field last changed
       *  `name` sorts by the field name
       *  `screensCount` sorts by the number of screens related to a field
    * `expand`: Use [expand](#expansion) to include additional information in the response. This parameter accepts a comma-separated list. Expand options include:

       *  `key` returns the key for each field
       *  `stableId` returns the stableId for each field
       *  `lastUsed` returns the date when the value of the field last changed
       *  `screensCount` returns the number of screens related to a field
       *  `contextsCount` returns the number of contexts related to a field
       *  `isLocked` returns information about whether the field is [locked](https://confluence.atlassian.com/x/ZSN7Og)
       *  `searcherKey` returns the searcher key for each custom field

  """
  @spec get_fields_paginated(keyword) ::
          {:ok, Jirex.PageBeanField.t()} | {:error, Jirex.ErrorCollection.t()}
  def get_fields_paginated(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:expand, :id, :maxResults, :orderBy, :query, :startAt, :type])

    client.request(%{
      args: [],
      call: {Jirex.IssueFields, :get_fields_paginated},
      url: "/rest/api/2/field/search",
      method: :get,
      query: query,
      response: [
        {200, {Jirex.PageBeanField, :t}},
        {400, {Jirex.ErrorCollection, :t}},
        {401, :null},
        {403, {Jirex.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get fields in trash paginated

  Returns a [paginated](#pagination) list of fields in the trash. The list may be restricted to fields whose field name or description partially match a string.

  Only custom fields can be queried, `type` must be set to `custom`.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.
    * `id`
    * `query`: String used to perform a case-insensitive partial match with field names or descriptions.
    * `expand`
    * `orderBy`: [Order](#ordering) the results by a field:

       *  `name` sorts by the field name
       *  `trashDate` sorts by the date the field was moved to the trash
       *  `plannedDeletionDate` sorts by the planned deletion date

  """
  @spec get_trashed_fields_paginated(keyword) ::
          {:ok, Jirex.PageBeanField.t()} | {:error, Jirex.ErrorCollection.t()}
  def get_trashed_fields_paginated(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:expand, :id, :maxResults, :orderBy, :query, :startAt])

    client.request(%{
      args: [],
      call: {Jirex.IssueFields, :get_trashed_fields_paginated},
      url: "/rest/api/2/field/search/trashed",
      method: :get,
      query: query,
      response: [
        {200, {Jirex.PageBeanField, :t}},
        {400, {Jirex.ErrorCollection, :t}},
        {401, :null},
        {403, {Jirex.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Restore custom field from trash

  Restores a custom field from trash. See [Edit or delete a custom field](https://confluence.atlassian.com/x/Z44fOw) for more information on trashing and deleting custom fields.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec restore_custom_field(String.t(), keyword) ::
          {:ok, map} | {:error, Jirex.ErrorCollection.t()}
  def restore_custom_field(id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id],
      call: {Jirex.IssueFields, :restore_custom_field},
      url: "/rest/api/2/field/#{id}/restore",
      method: :post,
      response: [
        {200, :map},
        {400, {Jirex.ErrorCollection, :t}},
        {401, {Jirex.ErrorCollection, :t}},
        {403, {Jirex.ErrorCollection, :t}},
        {404, {Jirex.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Move custom field to trash

  Moves a custom field to trash. See [Edit or delete a custom field](https://confluence.atlassian.com/x/Z44fOw) for more information on trashing and deleting custom fields.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec trash_custom_field(String.t(), keyword) ::
          {:ok, map} | {:error, Jirex.ErrorCollection.t()}
  def trash_custom_field(id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [id: id],
      call: {Jirex.IssueFields, :trash_custom_field},
      url: "/rest/api/2/field/#{id}/trash",
      method: :post,
      response: [
        {200, :map},
        {400, {Jirex.ErrorCollection, :t}},
        {401, {Jirex.ErrorCollection, :t}},
        {403, {Jirex.ErrorCollection, :t}},
        {404, {Jirex.ErrorCollection, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Update custom field

  Updates a custom field.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).
  """
  @spec update_custom_field(String.t(), Jirex.UpdateCustomFieldDetails.t(), keyword) ::
          {:ok, map} | {:error, any}
  def update_custom_field(fieldId, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [fieldId: fieldId, body: body],
      call: {Jirex.IssueFields, :update_custom_field},
      url: "/rest/api/2/field/#{fieldId}",
      body: body,
      method: :put,
      request: [{"application/json", {Jirex.UpdateCustomFieldDetails, :t}}],
      response: [{204, :map}, {400, :unknown}, {401, :null}, {403, :unknown}, {404, :unknown}],
      opts: opts
    })
  end
end
