defmodule Jira.ContextForProjectAndIssueType do
  @moduledoc """
  Provides struct and type for a ContextForProjectAndIssueType
  """

  @type t :: %__MODULE__{contextId: String.t(), issueTypeId: String.t(), projectId: String.t()}

  defstruct [:contextId, :issueTypeId, :projectId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      contextId: {:string, :generic},
      issueTypeId: {:string, :generic},
      projectId: {:string, :generic}
    ]
  end
end
