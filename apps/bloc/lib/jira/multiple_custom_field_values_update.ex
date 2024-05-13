defmodule Jira.MultipleCustomFieldValuesUpdate do
  @moduledoc """
  Provides struct and type for a MultipleCustomFieldValuesUpdate
  """

  @type t :: %__MODULE__{customField: String.t(), issueIds: [integer], value: map}

  defstruct [:customField, :issueIds, :value]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [customField: {:string, :generic}, issueIds: [:integer], value: :map]
  end
end
