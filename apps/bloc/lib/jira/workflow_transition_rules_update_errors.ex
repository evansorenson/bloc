defmodule Jira.WorkflowTransitionRulesUpdateErrors do
  @moduledoc """
  Provides struct and type for a WorkflowTransitionRulesUpdateErrors
  """

  @type t :: %__MODULE__{updateResults: [Jira.WorkflowTransitionRulesUpdateErrorDetails.t()]}

  defstruct [:updateResults]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [updateResults: [{Jira.WorkflowTransitionRulesUpdateErrorDetails, :t}]]
  end
end
