defmodule Jirex.WorkflowCreate do
  @moduledoc """
  Provides struct and type for a WorkflowCreate
  """

  @type t :: %__MODULE__{
          description: String.t() | nil,
          name: String.t(),
          startPointLayout: Jirex.WorkflowLayout.t() | nil,
          statuses: [Jirex.StatusLayoutUpdate.t()],
          transitions: [Jirex.TransitionUpdateDTO.t()]
        }

  defstruct [:description, :name, :startPointLayout, :statuses, :transitions]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      description: {:string, :generic},
      name: {:string, :generic},
      startPointLayout: {Jirex.WorkflowLayout, :t},
      statuses: [{Jirex.StatusLayoutUpdate, :t}],
      transitions: [{Jirex.TransitionUpdateDTO, :t}]
    ]
  end
end
