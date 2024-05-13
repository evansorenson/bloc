defmodule Jira.JQLReferenceData do
  @moduledoc """
  Provides struct and type for a JQLReferenceData
  """

  @type t :: %__MODULE__{
          jqlReservedWords: [String.t()] | nil,
          visibleFieldNames: [Jira.FieldReferenceData.t()] | nil,
          visibleFunctionNames: [Jira.FunctionReferenceData.t()] | nil
        }

  defstruct [:jqlReservedWords, :visibleFieldNames, :visibleFunctionNames]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      jqlReservedWords: [string: :generic],
      visibleFieldNames: [{Jira.FieldReferenceData, :t}],
      visibleFunctionNames: [{Jira.FunctionReferenceData, :t}]
    ]
  end
end
