defmodule Jirex.TransitionUpdateDTO do
  @moduledoc """
  Provides struct and type for a TransitionUpdateDTO
  """

  @type t :: %__MODULE__{
          actions: [Jirex.WorkflowRuleConfiguration.t()] | nil,
          conditions: Jirex.ConditionGroupUpdate.t() | nil,
          customIssueEventId: String.t() | nil,
          description: String.t() | nil,
          from: [Jirex.StatusReferenceAndPort.t()] | nil,
          id: String.t(),
          name: String.t(),
          properties: Jirex.TransitionUpdateDTOProperties.t() | nil,
          to: Jirex.StatusReferenceAndPort.t() | nil,
          transitionScreen: Jirex.WorkflowRuleConfiguration.t() | nil,
          triggers: [Jirex.WorkflowTrigger.t()] | nil,
          type: String.t(),
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
      conditions: {Jirex.ConditionGroupUpdate, :t},
      customIssueEventId: {:string, :generic},
      description: {:string, :generic},
      from: [{Jirex.StatusReferenceAndPort, :t}],
      id: {:string, :generic},
      name: {:string, :generic},
      properties: {Jirex.TransitionUpdateDTOProperties, :t},
      to: {Jirex.StatusReferenceAndPort, :t},
      transitionScreen: {Jirex.WorkflowRuleConfiguration, :t},
      triggers: [{Jirex.WorkflowTrigger, :t}],
      type: {:enum, ["INITIAL", "GLOBAL", "DIRECTED"]},
      validators: [{Jirex.WorkflowRuleConfiguration, :t}]
    ]
  end
end
