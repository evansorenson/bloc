defmodule Jirex.FunctionReferenceData do
  @moduledoc """
  Provides struct and type for a FunctionReferenceData
  """

  @type t :: %__MODULE__{
          displayName: String.t() | nil,
          isList: String.t() | nil,
          supportsListAndSingleValueOperators: String.t() | nil,
          types: [String.t()] | nil,
          value: String.t() | nil
        }

  defstruct [:displayName, :isList, :supportsListAndSingleValueOperators, :types, :value]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      displayName: {:string, :generic},
      isList: {:enum, ["true", "false"]},
      supportsListAndSingleValueOperators: {:enum, ["true", "false"]},
      types: [string: :generic],
      value: {:string, :generic}
    ]
  end
end
