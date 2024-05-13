defmodule Jira.WorkflowTrigger do
  @moduledoc """
  Provides struct and type for a WorkflowTrigger
  """

  @type t :: %__MODULE__{
          id: String.t() | nil,
          parameters: Jira.WorkflowTriggerParameters.t(),
          ruleKey: String.t()
        }

  defstruct [:id, :parameters, :ruleKey]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      id: {:string, :generic},
      parameters: {Jira.WorkflowTriggerParameters, :t},
      ruleKey: {:string, :generic}
    ]
  end
end
