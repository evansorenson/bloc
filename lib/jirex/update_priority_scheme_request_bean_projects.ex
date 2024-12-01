defmodule Jirex.UpdatePrioritySchemeRequestBeanProjects do
  @moduledoc """
  Provides struct and type for a UpdatePrioritySchemeRequestBeanProjects
  """

  @type t :: %__MODULE__{
          add: Jirex.UpdatePrioritySchemeRequestBeanProjectsAdd.t() | nil,
          remove: Jirex.UpdatePrioritySchemeRequestBeanProjectsRemove.t() | nil
        }

  defstruct [:add, :remove]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      add: {Jirex.UpdatePrioritySchemeRequestBeanProjectsAdd, :t},
      remove: {Jirex.UpdatePrioritySchemeRequestBeanProjectsRemove, :t}
    ]
  end
end
