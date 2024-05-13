defmodule Jira.AutoCompleteSuggestion do
  @moduledoc """
  Provides struct and type for a AutoCompleteSuggestion
  """

  @type t :: %__MODULE__{displayName: String.t() | nil, value: String.t() | nil}

  defstruct [:displayName, :value]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [displayName: {:string, :generic}, value: {:string, :generic}]
  end
end
