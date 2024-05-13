defmodule Jira.WorkflowValidationErrorList do
  @moduledoc """
  Provides struct and type for a WorkflowValidationErrorList
  """

  @type t :: %__MODULE__{errors: [Jira.WorkflowValidationError.t()] | nil}

  defstruct [:errors]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [errors: [{Jira.WorkflowValidationError, :t}]]
  end
end
