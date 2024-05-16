defmodule Jirex.UpdatePrioritySchemeRequestBeanPriorities do
  @moduledoc """
  Provides struct and type for a UpdatePrioritySchemeRequestBeanPriorities
  """

  @type t :: %__MODULE__{
          add: Jirex.UpdatePrioritySchemeRequestBeanPrioritiesAdd.t() | nil,
          remove: Jirex.UpdatePrioritySchemeRequestBeanPrioritiesRemove.t() | nil
        }

  defstruct [:add, :remove]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      add: {Jirex.UpdatePrioritySchemeRequestBeanPrioritiesAdd, :t},
      remove: {Jirex.UpdatePrioritySchemeRequestBeanPrioritiesRemove, :t}
    ]
  end
end
