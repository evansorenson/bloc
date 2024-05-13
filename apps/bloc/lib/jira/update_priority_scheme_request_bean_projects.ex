defmodule Jira.UpdatePrioritySchemeRequestBeanProjects do
  @moduledoc """
  Provides struct and type for a UpdatePrioritySchemeRequestBeanProjects
  """

  @type t :: %__MODULE__{
          add: Jira.UpdatePrioritySchemeRequestBeanProjectsAdd.t() | nil,
          remove: Jira.UpdatePrioritySchemeRequestBeanProjectsRemove.t() | nil
        }

  defstruct [:add, :remove]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      add: {Jira.UpdatePrioritySchemeRequestBeanProjectsAdd, :t},
      remove: {Jira.UpdatePrioritySchemeRequestBeanProjectsRemove, :t}
    ]
  end
end
