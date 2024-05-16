defmodule Jirex.CustomFieldOptionCreate do
  @moduledoc """
  Provides struct and type for a CustomFieldOptionCreate
  """

  @type t :: %__MODULE__{disabled: boolean | nil, optionId: String.t() | nil, value: String.t()}

  defstruct [:disabled, :optionId, :value]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [disabled: :boolean, optionId: {:string, :generic}, value: {:string, :generic}]
  end
end
