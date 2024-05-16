defmodule Jirex.BulkIssuePropertyUpdateRequest do
  @moduledoc """
  Provides struct and type for a BulkIssuePropertyUpdateRequest
  """

  @type t :: %__MODULE__{
          expression: String.t() | nil,
          filter: Jirex.BulkIssuePropertyUpdateRequestFilter.t() | nil,
          value: map | nil
        }

  defstruct [:expression, :filter, :value]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      expression: {:string, :generic},
      filter: {Jirex.BulkIssuePropertyUpdateRequestFilter, :t},
      value: :map
    ]
  end
end
