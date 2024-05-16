defmodule Jirex.CustomFieldValueUpdate do
  @moduledoc """
  Provides struct and type for a CustomFieldValueUpdate
  """

  @type t :: %__MODULE__{issueIds: [integer], value: map}

  defstruct [:issueIds, :value]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [issueIds: [:integer], value: :map]
  end
end
