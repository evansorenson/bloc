defmodule Jira.WorkflowTransitionProperties do
  @moduledoc """
  Provides API endpoints related to workflow transition properties
  """

  @default_client Jira.Client

  @doc """
  Create workflow transition property

  Adds a property to a workflow transition. Transition properties are used to change the behavior of a transition. For more information, see [Transition properties](https://confluence.atlassian.com/x/zIhKLg#Advancedworkflowconfiguration-transitionproperties) and [Workflow properties](https://confluence.atlassian.com/x/JYlKLg).

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `key`: The key of the property being added, also known as the name of the property. Set this to the same value as the `key` defined in the request body.
    * `workflowName`: The name of the workflow that the transition belongs to.
    * `workflowMode`: The workflow status. Set to *live* for inactive workflows or *draft* for draft workflows. Active workflows cannot be edited.

  """
  @spec create_workflow_transition_property(integer, Jira.WorkflowTransitionProperty.t(), keyword) ::
          {:ok, Jira.WorkflowTransitionProperty.t()} | :error
  def create_workflow_transition_property(transitionId, body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:key, :workflowMode, :workflowName])

    client.request(%{
      args: [transitionId: transitionId, body: body],
      call: {Jira.WorkflowTransitionProperties, :create_workflow_transition_property},
      url: "/rest/api/2/workflow/transitions/#{transitionId}/properties",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", {Jira.WorkflowTransitionProperty, :t}}],
      response: [
        {200, {Jira.WorkflowTransitionProperty, :t}},
        {400, :null},
        {401, :null},
        {403, :null},
        {404, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Delete workflow transition property

  Deletes a property from a workflow transition. Transition properties are used to change the behavior of a transition. For more information, see [Transition properties](https://confluence.atlassian.com/x/zIhKLg#Advancedworkflowconfiguration-transitionproperties) and [Workflow properties](https://confluence.atlassian.com/x/JYlKLg).

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `key`: The name of the transition property to delete, also known as the name of the property.
    * `workflowName`: The name of the workflow that the transition belongs to.
    * `workflowMode`: The workflow status. Set to `live` for inactive workflows or `draft` for draft workflows. Active workflows cannot be edited.

  """
  @spec delete_workflow_transition_property(integer, keyword) :: :ok | :error
  def delete_workflow_transition_property(transitionId, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:key, :workflowMode, :workflowName])

    client.request(%{
      args: [transitionId: transitionId],
      call: {Jira.WorkflowTransitionProperties, :delete_workflow_transition_property},
      url: "/rest/api/2/workflow/transitions/#{transitionId}/properties",
      method: :delete,
      query: query,
      response: [
        {200, :null},
        {304, :null},
        {400, :null},
        {401, :null},
        {403, :null},
        {404, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Get workflow transition properties

  Returns the properties on a workflow transition. Transition properties are used to change the behavior of a transition. For more information, see [Transition properties](https://confluence.atlassian.com/x/zIhKLg#Advancedworkflowconfiguration-transitionproperties) and [Workflow properties](https://confluence.atlassian.com/x/JYlKLg).

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `includeReservedKeys`: Some properties with keys that have the *jira.* prefix are reserved, which means they are not editable. To include these properties in the results, set this parameter to *true*.
    * `key`: The key of the property being returned, also known as the name of the property. If this parameter is not specified, all properties on the transition are returned.
    * `workflowName`: The name of the workflow that the transition belongs to.
    * `workflowMode`: The workflow status. Set to *live* for active and inactive workflows, or *draft* for draft workflows.

  """
  @spec get_workflow_transition_properties(integer, keyword) ::
          {:ok, Jira.WorkflowTransitionProperty.t()} | :error
  def get_workflow_transition_properties(transitionId, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:includeReservedKeys, :key, :workflowMode, :workflowName])

    client.request(%{
      args: [transitionId: transitionId],
      call: {Jira.WorkflowTransitionProperties, :get_workflow_transition_properties},
      url: "/rest/api/2/workflow/transitions/#{transitionId}/properties",
      method: :get,
      query: query,
      response: [
        {200, {Jira.WorkflowTransitionProperty, :t}},
        {400, :null},
        {401, :null},
        {403, :null},
        {404, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Update workflow transition property

  Updates a workflow transition by changing the property value. Trying to update a property that does not exist results in a new property being added to the transition. Transition properties are used to change the behavior of a transition. For more information, see [Transition properties](https://confluence.atlassian.com/x/zIhKLg#Advancedworkflowconfiguration-transitionproperties) and [Workflow properties](https://confluence.atlassian.com/x/JYlKLg).

  **[Permissions](#permissions) required:** *Administer Jira* [global permission](https://confluence.atlassian.com/x/x4dKLg).

  ## Options

    * `key`: The key of the property being updated, also known as the name of the property. Set this to the same value as the `key` defined in the request body.
    * `workflowName`: The name of the workflow that the transition belongs to.
    * `workflowMode`: The workflow status. Set to `live` for inactive workflows or `draft` for draft workflows. Active workflows cannot be edited.

  """
  @spec update_workflow_transition_property(integer, Jira.WorkflowTransitionProperty.t(), keyword) ::
          {:ok, Jira.WorkflowTransitionProperty.t()} | :error
  def update_workflow_transition_property(transitionId, body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:key, :workflowMode, :workflowName])

    client.request(%{
      args: [transitionId: transitionId, body: body],
      call: {Jira.WorkflowTransitionProperties, :update_workflow_transition_property},
      url: "/rest/api/2/workflow/transitions/#{transitionId}/properties",
      body: body,
      method: :put,
      query: query,
      request: [{"application/json", {Jira.WorkflowTransitionProperty, :t}}],
      response: [
        {200, {Jira.WorkflowTransitionProperty, :t}},
        {304, :null},
        {400, :null},
        {401, :null},
        {403, :null},
        {404, :null}
      ],
      opts: opts
    })
  end
end
