defmodule Jira.UpdatePrioritySchemeRequestBeanPriorities do
  @moduledoc """
  Provides struct and type for a UpdatePrioritySchemeRequestBeanPriorities
  """

  @type t :: %__MODULE__{
          add: Jira.UpdatePrioritySchemeRequestBeanPrioritiesAdd.t() | nil,
          remove: Jira.UpdatePrioritySchemeRequestBeanPrioritiesRemove.t() | nil
        }

  defstruct [:add, :remove]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      add: {Jira.UpdatePrioritySchemeRequestBeanPrioritiesAdd, :t},
      remove: {Jira.UpdatePrioritySchemeRequestBeanPrioritiesRemove, :t}
    ]
  end
end
