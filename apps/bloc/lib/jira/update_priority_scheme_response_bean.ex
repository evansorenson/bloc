defmodule Jira.UpdatePrioritySchemeResponseBean do
  @moduledoc """
  Provides struct and type for a UpdatePrioritySchemeResponseBean
  """

  @type t :: %__MODULE__{
          priorityScheme: Jira.PrioritySchemeWithPaginatedPrioritiesAndProjects.t() | nil,
          task: Jira.UpdatePrioritySchemeResponseBeanTask.t() | nil
        }

  defstruct [:priorityScheme, :task]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      priorityScheme: {Jira.PrioritySchemeWithPaginatedPrioritiesAndProjects, :t},
      task: {Jira.UpdatePrioritySchemeResponseBeanTask, :t}
    ]
  end
end
