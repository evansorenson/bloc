defmodule Jirex.WorkflowSchemeAssociations do
  @moduledoc """
  Provides struct and type for a WorkflowSchemeAssociations
  """

  @type t :: %__MODULE__{
          projectIds: [String.t()],
          workflowScheme: Jirex.WorkflowSchemeAssociationsWorkflowScheme.t()
        }

  defstruct [:projectIds, :workflowScheme]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      projectIds: [string: :generic],
      workflowScheme: {Jirex.WorkflowSchemeAssociationsWorkflowScheme, :t}
    ]
  end
end
