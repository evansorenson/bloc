defmodule Jirex.SuggestedMappingsRequestBeanPriorities do
  @moduledoc """
  Provides struct and type for a SuggestedMappingsRequestBeanPriorities
  """

  @type t :: %__MODULE__{add: [integer] | nil, remove: [integer] | nil}

  defstruct [:add, :remove]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [add: [:integer], remove: [:integer]]
  end
end
