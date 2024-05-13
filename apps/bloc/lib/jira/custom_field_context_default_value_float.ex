defmodule Jira.CustomFieldContextDefaultValueFloat do
  @moduledoc """
  Provides struct and type for a CustomFieldContextDefaultValueFloat
  """

  @type t :: %__MODULE__{number: number, type: String.t()}

  defstruct [:number, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [number: :number, type: {:string, :generic}]
  end
end
