defmodule Jirex.DetailedErrorCollection do
  @moduledoc """
  Provides struct and type for a DetailedErrorCollection
  """

  @type t :: %__MODULE__{
          details: Jirex.DetailedErrorCollectionDetails.t() | nil,
          errorMessages: [String.t()] | nil,
          errors: Jirex.DetailedErrorCollectionErrors.t() | nil
        }

  defstruct [:details, :errorMessages, :errors]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      details: {Jirex.DetailedErrorCollectionDetails, :t},
      errorMessages: [string: :generic],
      errors: {Jirex.DetailedErrorCollectionErrors, :t}
    ]
  end
end
