defmodule Jira.WorkflowRulesSearch do
  @moduledoc """
  Provides struct and type for a WorkflowRulesSearch
  """

  @type t :: %__MODULE__{
          expand: String.t() | nil,
          ruleIds: [String.t()],
          workflowEntityId: String.t()
        }

  defstruct [:expand, :ruleIds, :workflowEntityId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [expand: {:string, :generic}, ruleIds: [string: :uuid], workflowEntityId: {:string, :uuid}]
  end
end
