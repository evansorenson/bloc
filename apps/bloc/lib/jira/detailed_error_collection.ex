defmodule Jira.DetailedErrorCollection do
  @moduledoc """
  Provides struct and type for a DetailedErrorCollection
  """

  @type t :: %__MODULE__{
          details: Jira.DetailedErrorCollectionDetails.t() | nil,
          errorMessages: [String.t()] | nil,
          errors: Jira.DetailedErrorCollectionErrors.t() | nil
        }

  defstruct [:details, :errorMessages, :errors]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      details: {Jira.DetailedErrorCollectionDetails, :t},
      errorMessages: [string: :generic],
      errors: {Jira.DetailedErrorCollectionErrors, :t}
    ]
  end
end
