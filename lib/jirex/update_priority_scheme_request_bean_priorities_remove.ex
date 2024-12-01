defmodule Jirex.UpdatePrioritySchemeRequestBeanPrioritiesRemove do
  @moduledoc """
  Provides struct and type for a UpdatePrioritySchemeRequestBeanPrioritiesRemove
  """

  @type t :: %__MODULE__{ids: [integer] | nil, mappings: [Jirex.PriorityMapping.t()] | nil}

  defstruct [:ids, :mappings]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [ids: [:integer], mappings: [{Jirex.PriorityMapping, :t}]]
  end
end
