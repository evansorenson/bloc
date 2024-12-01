defmodule Jirex.CustomFieldContextDefaultValueSingleVersionPicker do
  @moduledoc """
  Provides struct and type for a CustomFieldContextDefaultValueSingleVersionPicker
  """

  @type t :: %__MODULE__{type: String.t(), versionId: String.t(), versionOrder: String.t() | nil}

  defstruct [:type, :versionId, :versionOrder]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [type: {:string, :generic}, versionId: {:string, :generic}, versionOrder: {:string, :generic}]
  end
end
