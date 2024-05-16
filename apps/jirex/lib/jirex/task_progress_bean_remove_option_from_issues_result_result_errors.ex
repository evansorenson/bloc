defmodule Jirex.TaskProgressBeanRemoveOptionFromIssuesResultResultErrors do
  @moduledoc """
  Provides struct and type for a TaskProgressBeanRemoveOptionFromIssuesResultResultErrors
  """

  @type t :: %__MODULE__{
          errorMessages: [String.t()] | nil,
          errors: Jirex.TaskProgressBeanRemoveOptionFromIssuesResultResultErrorsErrors.t() | nil,
          httpStatusCode: integer | nil
        }

  defstruct [:errorMessages, :errors, :httpStatusCode]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      errorMessages: [string: :generic],
      errors: {Jirex.TaskProgressBeanRemoveOptionFromIssuesResultResultErrorsErrors, :t},
      httpStatusCode: :integer
    ]
  end
end
