defmodule Jirex.AppMigration do
  @moduledoc """
  Provides API endpoints related to app migration
  """

  @default_client Jirex.Client

  @doc """
  Bulk update custom field value

  Updates the value of a custom field added by Connect apps on one or more issues.
  The values of up to 200 custom fields can be updated.

  **[Permissions](#permissions) required:** Only Connect apps can make this request
  """
  @spec app_issue_field_value_update_resource_update_issue_fields_put(
          Jirex.ConnectCustomFieldValues.t(),
          keyword
        ) :: {:ok, map} | :error
  def app_issue_field_value_update_resource_update_issue_fields_put(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jirex.AppMigration, :app_issue_field_value_update_resource_update_issue_fields_put},
      url: "/rest/atlassian-connect/1/migration/field",
      body: body,
      method: :put,
      request: [{"application/json", {Jirex.ConnectCustomFieldValues, :t}}],
      response: [{200, :map}, {400, :null}, {403, :null}],
      opts: opts
    })
  end

  @doc """
  Bulk update entity properties

  Updates the values of multiple entity properties for an object, up to 50 updates per request. This operation is for use by Connect apps during app migration.
  """
  @spec migration_resource_update_entity_properties_value_put(
          String.t(),
          [Jirex.EntityPropertyDetails.t()],
          keyword
        ) :: :ok | :error
  def migration_resource_update_entity_properties_value_put(entityType, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [entityType: entityType, body: body],
      call: {Jirex.AppMigration, :migration_resource_update_entity_properties_value_put},
      url: "/rest/atlassian-connect/1/migration/properties/#{entityType}",
      body: body,
      method: :put,
      request: [{"application/json", [{Jirex.EntityPropertyDetails, :t}]}],
      response: [{200, :null}, {400, :null}, {403, :null}],
      opts: opts
    })
  end

  @doc """
  Get workflow transition rule configurations

  Returns configurations for workflow transition rules migrated from server to cloud and owned by the calling Connect app.
  """
  @spec migration_resource_workflow_rule_search_post(Jirex.WorkflowRulesSearch.t(), keyword) ::
          {:ok, Jirex.WorkflowRulesSearchDetails.t()} | :error
  def migration_resource_workflow_rule_search_post(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Jirex.AppMigration, :migration_resource_workflow_rule_search_post},
      url: "/rest/atlassian-connect/1/migration/workflow/rule/search",
      body: body,
      method: :post,
      request: [{"application/json", {Jirex.WorkflowRulesSearch, :t}}],
      response: [{200, {Jirex.WorkflowRulesSearchDetails, :t}}, {400, :null}, {403, :null}],
      opts: opts
    })
  end
end
