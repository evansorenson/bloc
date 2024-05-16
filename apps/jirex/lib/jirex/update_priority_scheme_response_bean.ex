defmodule Jirex.UpdatePrioritySchemeResponseBean do
  @moduledoc """
  Provides struct and type for a UpdatePrioritySchemeResponseBean
  """

  @type t :: %__MODULE__{
          priorityScheme: Jirex.PrioritySchemeWithPaginatedPrioritiesAndProjects.t() | nil,
          task: Jirex.UpdatePrioritySchemeResponseBeanTask.t() | nil
        }

  defstruct [:priorityScheme, :task]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      priorityScheme: {Jirex.PrioritySchemeWithPaginatedPrioritiesAndProjects, :t},
      task: {Jirex.UpdatePrioritySchemeResponseBeanTask, :t}
    ]
  end
end
