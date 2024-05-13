defmodule Jira.TaskProgressBeanRemoveOptionFromIssuesResultResult do
  @moduledoc """
  Provides struct and type for a TaskProgressBeanRemoveOptionFromIssuesResultResult
  """

  @type t :: %__MODULE__{
          errors: Jira.TaskProgressBeanRemoveOptionFromIssuesResultResultErrors.t() | nil,
          modifiedIssues: [integer] | nil,
          unmodifiedIssues: [integer] | nil
        }

  defstruct [:errors, :modifiedIssues, :unmodifiedIssues]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      errors: {Jira.TaskProgressBeanRemoveOptionFromIssuesResultResultErrors, :t},
      modifiedIssues: [:integer],
      unmodifiedIssues: [:integer]
    ]
  end
end
