defmodule Jira.WorkflowCapabilities do
  @moduledoc """
  Provides struct and type for a WorkflowCapabilities
  """

  @type t :: %__MODULE__{
          connectRules: [Jira.AvailableWorkflowConnectRule.t()] | nil,
          editorScope: String.t() | nil,
          forgeRules: [Jira.AvailableWorkflowForgeRule.t()] | nil,
          projectTypes: [String.t()] | nil,
          systemRules: [Jira.AvailableWorkflowSystemRule.t()] | nil,
          triggerRules: [Jira.AvailableWorkflowTriggers.t()] | nil
        }

  defstruct [:connectRules, :editorScope, :forgeRules, :projectTypes, :systemRules, :triggerRules]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      connectRules: [{Jira.AvailableWorkflowConnectRule, :t}],
      editorScope: {:enum, ["PROJECT", "GLOBAL"]},
      forgeRules: [{Jira.AvailableWorkflowForgeRule, :t}],
      projectTypes: [
        enum: ["software", "service_desk", "product_discovery", "business", "unknown"]
      ],
      systemRules: [{Jira.AvailableWorkflowSystemRule, :t}],
      triggerRules: [{Jira.AvailableWorkflowTriggers, :t}]
    ]
  end
end
