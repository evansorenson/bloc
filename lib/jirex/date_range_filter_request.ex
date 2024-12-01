defmodule Jirex.DateRangeFilterRequest do
  @moduledoc """
  Provides struct and type for a DateRangeFilterRequest
  """

  @type t :: %__MODULE__{dateAfter: String.t(), dateBefore: String.t()}

  defstruct [:dateAfter, :dateBefore]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [dateAfter: {:string, :generic}, dateBefore: {:string, :generic}]
  end
end
