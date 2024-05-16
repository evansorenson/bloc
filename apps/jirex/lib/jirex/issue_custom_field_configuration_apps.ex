defmodule Jirex.IssueCustomFieldConfigurationApps do
  @moduledoc """
  Provides API endpoints related to issue custom field configuration apps
  """

  @default_client Jirex.Client

  @doc """
  Get custom field configurations

  Returns a [paginated](#pagination) list of configurations for a custom field of a [type](https://developer.atlassian.com/platform/forge/manifest-reference/modules/jira-custom-field-type/) created by a [Forge app](https://developer.atlassian.com/platform/forge/).

  The result can be filtered by one of these criteria:

   *  `id`.
   *  `fieldContextId`.
   *  `issueId`.
   *  `projectKeyOrId` and `issueTypeId`.

  Otherwise, all configurations are returned.

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg). Jira permissions are not required for the Forge app that provided the custom field type.

  ## Options

    * `id`: The list of configuration IDs. To include multiple configurations, separate IDs with an ampersand: `id=10000&id=10001`. Can't be provided with `fieldContextId`, `issueId`, `projectKeyOrId`, or `issueTypeId`.
    * `fieldContextId`: The list of field context IDs. To include multiple field contexts, separate IDs with an ampersand: `fieldContextId=10000&fieldContextId=10001`. Can't be provided with `id`, `issueId`, `projectKeyOrId`, or `issueTypeId`.
    * `issueId`: The ID of the issue to filter results by. If the issue doesn't exist, an empty list is returned. Can't be provided with `projectKeyOrId`, or `issueTypeId`.
    * `projectKeyOrId`: The ID or key of the project to filter results by. Must be provided with `issueTypeId`. Can't be provided with `issueId`.
    * `issueTypeId`: The ID of the issue type to filter results by. Must be provided with `projectKeyOrId`. Can't be provided with `issueId`.
    * `startAt`: The index of the first item to return in a page of results (page offset).
    * `maxResults`: The maximum number of items to return per page.

  """
  @spec get_custom_field_configuration(String.t(), keyword) ::
          {:ok, Jirex.PageBeanContextualConfiguration.t()} | :error
  def get_custom_field_configuration(fieldIdOrKey, opts \\ []) do
    client = opts[:client] || @default_client

    query =
      Keyword.take(opts, [
        :fieldContextId,
        :id,
        :issueId,
        :issueTypeId,
        :maxResults,
        :projectKeyOrId,
        :startAt
      ])

    client.request(%{
      args: [fieldIdOrKey: fieldIdOrKey],
      call: {Jirex.IssueCustomFieldConfigurationApps, :get_custom_field_configuration},
      url: "/rest/api/2/app/field/#{fieldIdOrKey}/context/configuration",
      method: :get,
      query: query,
      response: [
        {200, {Jirex.PageBeanContextualConfiguration, :t}},
        {400, :null},
        {401, :null},
        {403, :null},
        {404, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Update custom field configurations

  Update the configuration for contexts of a custom field of a [type](https://developer.atlassian.com/platform/forge/manifest-reference/modules/jira-custom-field-type/) created by a [Forge app](https://developer.atlassian.com/platform/forge/).

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg). Jira permissions are not required for the Forge app that created the custom field type.
  """
  @spec update_custom_field_configuration(
          String.t(),
          Jirex.CustomFieldConfigurations.t(),
          keyword
        ) :: {:ok, map} | :error
  def update_custom_field_configuration(fieldIdOrKey, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [fieldIdOrKey: fieldIdOrKey, body: body],
      call: {Jirex.IssueCustomFieldConfigurationApps, :update_custom_field_configuration},
      url: "/rest/api/2/app/field/#{fieldIdOrKey}/context/configuration",
      body: body,
      method: :put,
      request: [{"application/json", {Jirex.CustomFieldConfigurations, :t}}],
      response: [{200, :map}, {400, :null}, {401, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end
end
