defmodule Jira.IssueTypeToContextMapping do
  @moduledoc """
  Provides struct and type for a IssueTypeToContextMapping
  """

  @type t :: %__MODULE__{
          contextId: String.t(),
          isAnyIssueType: boolean | nil,
          issueTypeId: String.t() | nil
        }

  defstruct [:contextId, :isAnyIssueType, :issueTypeId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [contextId: {:string, :generic}, isAnyIssueType: :boolean, issueTypeId: {:string, :generic}]
  end
end
