defmodule Jirex.WorkflowTransitions do
  @moduledoc """
  Provides struct and type for a WorkflowTransitions
  """

  @type t :: %__MODULE__{
          actions: [Jirex.WorkflowRuleConfiguration.t()] | nil,
          conditions: Jirex.ConditionGroupConfiguration.t() | nil,
          customIssueEventId: String.t() | nil,
          description: String.t() | nil,
          from: [Jirex.WorkflowStatusAndPort.t()] | nil,
          id: String.t() | nil,
          name: String.t() | nil,
          properties: Jirex.WorkflowTransitionsProperties.t() | nil,
          to: Jirex.WorkflowStatusAndPort.t() | nil,
          transitionScreen: Jirex.WorkflowRuleConfiguration.t() | nil,
          triggers: [Jirex.WorkflowTrigger.t()] | nil,
          type: String.t() | nil,
          validators: [Jirex.WorkflowRuleConfiguration.t()] | nil
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
      actions: [{Jirex.WorkflowRuleConfiguration, :t}],
      conditions: {Jirex.ConditionGroupConfiguration, :t},
      customIssueEventId: {:string, :generic},
      description: {:string, :generic},
      from: [{Jirex.WorkflowStatusAndPort, :t}],
      id: {:string, :generic},
      name: {:string, :generic},
      properties: {Jirex.WorkflowTransitionsProperties, :t},
      to: {Jirex.WorkflowStatusAndPort, :t},
      transitionScreen: {Jirex.WorkflowRuleConfiguration, :t},
      triggers: [{Jirex.WorkflowTrigger, :t}],
      type: {:enum, ["INITIAL", "GLOBAL", "DIRECTED"]},
      validators: [{Jirex.WorkflowRuleConfiguration, :t}]
    ]
  end
end
