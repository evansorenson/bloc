defmodule Jirex.AutoCompleteSuggestions do
  @moduledoc """
  Provides struct and type for a AutoCompleteSuggestions
  """

  @type t :: %__MODULE__{results: [Jirex.AutoCompleteSuggestion.t()] | nil}

  defstruct [:results]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [results: [{Jirex.AutoCompleteSuggestion, :t}]]
  end
end
