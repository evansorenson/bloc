defmodule Jira.WorkflowCreate do
  @moduledoc """
  Provides struct and type for a WorkflowCreate
  """

  @type t :: %__MODULE__{
          description: String.t() | nil,
          name: String.t(),
          startPointLayout: Jira.WorkflowLayout.t() | nil,
          statuses: [Jira.StatusLayoutUpdate.t()],
          transitions: [Jira.TransitionUpdateDTO.t()]
        }

  defstruct [:description, :name, :startPointLayout, :statuses, :transitions]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      description: {:string, :generic},
      name: {:string, :generic},
      startPointLayout: {Jira.WorkflowLayout, :t},
      statuses: [{Jira.StatusLayoutUpdate, :t}],
      transitions: [{Jira.TransitionUpdateDTO, :t}]
    ]
  end
end
