defmodule Jira.SanitizedJqlQuery do
  @moduledoc """
  Provides struct and type for a SanitizedJqlQuery
  """

  @type t :: %__MODULE__{
          accountId: String.t() | nil,
          errors: Jira.SanitizedJqlQueryErrors.t() | nil,
          initialQuery: String.t() | nil,
          sanitizedQuery: String.t() | nil
        }

  defstruct [:accountId, :errors, :initialQuery, :sanitizedQuery]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      accountId: {:string, :generic},
      errors: {Jira.SanitizedJqlQueryErrors, :t},
      initialQuery: {:string, :generic},
      sanitizedQuery: {:string, :generic}
    ]
  end
end
