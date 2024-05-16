defmodule Jirex.WorkflowMetadataAndIssueTypeRestModel do
  @moduledoc """
  Provides struct and type for a WorkflowMetadataAndIssueTypeRestModel
  """

  @type t :: %__MODULE__{
          issueTypeIds: [String.t()],
          workflow: Jirex.WorkflowMetadataRestModel.t()
        }

  defstruct [:issueTypeIds, :workflow]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [issueTypeIds: [string: :generic], workflow: {Jirex.WorkflowMetadataRestModel, :t}]
  end
end
