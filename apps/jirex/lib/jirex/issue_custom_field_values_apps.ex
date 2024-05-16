defmodule Jirex.IssueCustomFieldValuesApps do
  @moduledoc """
  Provides API endpoints related to issue custom field values apps
  """

  @default_client Jirex.Client

  @doc """
  Update custom field value

  Updates the value of a custom field on one or more issues.

  Apps can only perform this operation on [custom fields](https://developer.atlassian.com/platform/forge/manifest-reference/modules/jira-custom-field/) and [custom field types](https://developer.atlassian.com/platform/forge/manifest-reference/modules/jira-custom-field-type/) declared in their own manifests.

  **[Permissions](#permissions) required:** Only the app that owns the custom field or custom field type can update its values with this operation.

  ## Options

    * `generateChangelog`: Whether to generate a changelog for this update.

  """
  @spec update_custom_field_value(String.t(), Jirex.CustomFieldValueUpdateDetails.t(), keyword) ::
          {:ok, map} | :error
  def update_custom_field_value(fieldIdOrKey, body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:generateChangelog])

    client.request(%{
      args: [fieldIdOrKey: fieldIdOrKey, body: body],
      call: {Jirex.IssueCustomFieldValuesApps, :update_custom_field_value},
      url: "/rest/api/2/app/field/#{fieldIdOrKey}/value",
      body: body,
      method: :put,
      query: query,
      request: [{"application/json", {Jirex.CustomFieldValueUpdateDetails, :t}}],
      response: [{204, :map}, {400, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Update custom fields

  Updates the value of one or more custom fields on one or more issues. Combinations of custom field and issue should be unique within the request.

  Apps can only perform this operation on [custom fields](https://developer.atlassian.com/platform/forge/manifest-reference/modules/jira-custom-field/) and [custom field types](https://developer.atlassian.com/platform/forge/manifest-reference/modules/jira-custom-field-type/) declared in their own manifests.

  **[Permissions](#permissions) required:** Only the app that owns the custom field or custom field type can update its values with this operation.

  ## Options

    * `generateChangelog`: Whether to generate a changelog for this update.

  """
  @spec update_multiple_custom_field_values(
          Jirex.MultipleCustomFieldValuesUpdateDetails.t(),
          keyword
        ) :: {:ok, map} | :error
  def update_multiple_custom_field_values(body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:generateChangelog])

    client.request(%{
      args: [body: body],
      call: {Jirex.IssueCustomFieldValuesApps, :update_multiple_custom_field_values},
      url: "/rest/api/2/app/field/value",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Jirex.MultipleCustomFieldValuesUpdateDetails, :t}}],
      response: [{204, :map}, {400, :null}, {403, :null}, {404, :null}],
      opts: opts
    })
  end
end
