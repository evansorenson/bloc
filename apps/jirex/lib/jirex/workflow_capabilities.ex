defmodule Jirex.WorkflowCapabilities do
  @moduledoc """
  Provides struct and type for a WorkflowCapabilities
  """

  @type t :: %__MODULE__{
          connectRules: [Jirex.AvailableWorkflowConnectRule.t()] | nil,
          editorScope: String.t() | nil,
          forgeRules: [Jirex.AvailableWorkflowForgeRule.t()] | nil,
          projectTypes: [String.t()] | nil,
          systemRules: [Jirex.AvailableWorkflowSystemRule.t()] | nil,
          triggerRules: [Jirex.AvailableWorkflowTriggers.t()] | nil
        }

  defstruct [:connectRules, :editorScope, :forgeRules, :projectTypes, :systemRules, :triggerRules]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      connectRules: [{Jirex.AvailableWorkflowConnectRule, :t}],
      editorScope: {:enum, ["PROJECT", "GLOBAL"]},
      forgeRules: [{Jirex.AvailableWorkflowForgeRule, :t}],
      projectTypes: [
        enum: ["software", "service_desk", "product_discovery", "business", "unknown"]
      ],
      systemRules: [{Jirex.AvailableWorkflowSystemRule, :t}],
      triggerRules: [{Jirex.AvailableWorkflowTriggers, :t}]
    ]
  end
end
