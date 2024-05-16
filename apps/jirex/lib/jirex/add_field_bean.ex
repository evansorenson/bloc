defmodule Jirex.AddFieldBean do
  @moduledoc """
  Provides struct and type for a AddFieldBean
  """

  @type t :: %__MODULE__{fieldId: String.t()}

  defstruct [:fieldId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [fieldId: {:string, :generic}]
  end
end
