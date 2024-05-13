defmodule Jira.WorkflowsWithTransitionRulesDetails do
  @moduledoc """
  Provides struct and type for a WorkflowsWithTransitionRulesDetails
  """

  @type t :: %__MODULE__{workflows: [Jira.WorkflowTransitionRulesDetails.t()]}

  defstruct [:workflows]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [workflows: [{Jira.WorkflowTransitionRulesDetails, :t}]]
  end
end
