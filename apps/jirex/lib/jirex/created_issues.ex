defmodule Jirex.CreatedIssues do
  @moduledoc """
  Provides struct and type for a CreatedIssues
  """

  @type t :: %__MODULE__{
          errors: [Jirex.BulkOperationErrorResult.t()] | nil,
          issues: [Jirex.CreatedIssue.t()] | nil
        }

  defstruct [:errors, :issues]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [errors: [{Jirex.BulkOperationErrorResult, :t}], issues: [{Jirex.CreatedIssue, :t}]]
  end
end
