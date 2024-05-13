defmodule Jira.TransitionUpdateDTO do
  @moduledoc """
  Provides struct and type for a TransitionUpdateDTO
  """

  @type t :: %__MODULE__{
          actions: [Jira.WorkflowRuleConfiguration.t()] | nil,
          conditions: Jira.ConditionGroupUpdate.t() | nil,
          customIssueEventId: String.t() | nil,
          description: String.t() | nil,
          from: [Jira.StatusReferenceAndPort.t()] | nil,
          id: String.t(),
          name: String.t(),
          properties: Jira.TransitionUpdateDTOProperties.t() | nil,
          to: Jira.StatusReferenceAndPort.t() | nil,
          transitionScreen: Jira.WorkflowRuleConfiguration.t() | nil,
          triggers: [Jira.WorkflowTrigger.t()] | nil,
          type: String.t(),
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
      conditions: {Jira.ConditionGroupUpdate, :t},
      customIssueEventId: {:string, :generic},
      description: {:string, :generic},
      from: [{Jira.StatusReferenceAndPort, :t}],
      id: {:string, :generic},
      name: {:string, :generic},
      properties: {Jira.TransitionUpdateDTOProperties, :t},
      to: {Jira.StatusReferenceAndPort, :t},
      transitionScreen: {Jira.WorkflowRuleConfiguration, :t},
      triggers: [{Jira.WorkflowTrigger, :t}],
      type: {:enum, ["INITIAL", "GLOBAL", "DIRECTED"]},
      validators: [{Jira.WorkflowRuleConfiguration, :t}]
    ]
  end
end
