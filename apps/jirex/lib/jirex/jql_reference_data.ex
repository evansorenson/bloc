defmodule Jirex.JQLReferenceData do
  @moduledoc """
  Provides struct and type for a JQLReferenceData
  """

  @type t :: %__MODULE__{
          jqlReservedWords: [String.t()] | nil,
          visibleFieldNames: [Jirex.FieldReferenceData.t()] | nil,
          visibleFunctionNames: [Jirex.FunctionReferenceData.t()] | nil
        }

  defstruct [:jqlReservedWords, :visibleFieldNames, :visibleFunctionNames]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      jqlReservedWords: [string: :generic],
      visibleFieldNames: [{Jirex.FieldReferenceData, :t}],
      visibleFunctionNames: [{Jirex.FunctionReferenceData, :t}]
    ]
  end
end
