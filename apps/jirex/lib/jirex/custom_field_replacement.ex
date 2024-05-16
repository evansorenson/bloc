defmodule Jirex.CustomFieldReplacement do
  @moduledoc """
  Provides struct and type for a CustomFieldReplacement
  """

  @type t :: %__MODULE__{customFieldId: integer | nil, moveTo: integer | nil}

  defstruct [:customFieldId, :moveTo]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [customFieldId: :integer, moveTo: :integer]
  end
end
