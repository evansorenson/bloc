defmodule Jira.CustomFieldContextDefaultValueDate do
  @moduledoc """
  Provides struct and type for a CustomFieldContextDefaultValueDate
  """

  @type t :: %__MODULE__{date: String.t() | nil, type: String.t(), useCurrent: boolean | nil}

  defstruct [:date, :type, :useCurrent]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [date: {:string, :generic}, type: {:string, :generic}, useCurrent: :boolean]
  end
end
