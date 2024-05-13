defmodule Jira.WorkflowTransitions do
  @moduledoc """
  Provides struct and type for a WorkflowTransitions
  """

  @type t :: %__MODULE__{
          actions: [Jira.WorkflowRuleConfiguration.t()] | nil,
          conditions: Jira.ConditionGroupConfiguration.t() | nil,
          customIssueEventId: String.t() | nil,
          description: String.t() | nil,
          from: [Jira.WorkflowStatusAndPort.t()] | nil,
          id: String.t() | nil,
          name: String.t() | nil,
          properties: Jira.WorkflowTransitionsProperties.t() | nil,
          to: Jira.WorkflowStatusAndPort.t() | nil,
          transitionScreen: Jira.WorkflowRuleConfiguration.t() | nil,
          triggers: [Jira.WorkflowTrigger.t()] | nil,
          type: String.t() | nil,
          validators: [Jira.WorkflowRuleConfiguration.t()] | nil
        }

  defstruct [
    :actions,
    :conditions,
    :customIssueEventId,
    :description,
    :from,
    :id,
    :name,
    :properties,
    :to,
    :transitionScreen,
    :triggers,
    :type,
    :validators
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      actions: [{Jira.WorkflowRuleConfiguration, :t}],
      conditions: {Jira.ConditionGroupConfiguration, :t},
      customIssueEventId: {:string, :generic},
      description: {:string, :generic},
      from: [{Jira.WorkflowStatusAndPort, :t}],
      id: {:string, :generic},
      name: {:string, :generic},
      properties: {Jira.WorkflowTransitionsProperties, :t},
      to: {Jira.WorkflowStatusAndPort, :t},
      transitionScreen: {Jira.WorkflowRuleConfiguration, :t},
      triggers: [{Jira.WorkflowTrigger, :t}],
      type: {:enum, ["INITIAL", "GLOBAL", "DIRECTED"]},
      validators: [{Jira.WorkflowRuleConfiguration, :t}]
    ]
  end
end
