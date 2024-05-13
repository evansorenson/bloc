defmodule Jira.WorkflowTransitionRulesUpdate do
  @moduledoc """
  Provides struct and type for a WorkflowTransitionRulesUpdate
  """

  @type t :: %__MODULE__{workflows: [Jira.WorkflowTransitionRules.t()]}

  defstruct [:workflows]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [workflows: [{Jira.WorkflowTransitionRules, :t}]]
  end
end
