defmodule Jirex.WorkflowUpdate do
  @moduledoc """
  Provides struct and type for a WorkflowUpdate
  """

  @type t :: %__MODULE__{
          defaultStatusMappings: [Jirex.StatusMigration.t()] | nil,
          description: String.t() | nil,
          id: String.t(),
          startPointLayout: Jirex.WorkflowLayout.t() | nil,
          statusMappings: [Jirex.StatusMappingDTO.t()] | nil,
          statuses: [Jirex.StatusLayoutUpdate.t()],
          transitions: [Jirex.TransitionUpdateDTO.t()],
          version: Jirex.DocumentVersion.t()
        }

  defstruct [
    :defaultStatusMappings,
    :description,
    :id,
    :startPointLayout,
    :statusMappings,
    :statuses,
    :transitions,
    :version
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      defaultStatusMappings: [{Jirex.StatusMigration, :t}],
      description: {:string, :generic},
      id: {:string, :generic},
      startPointLayout: {Jirex.WorkflowLayout, :t},
      statusMappings: [{Jirex.StatusMappingDTO, :t}],
      statuses: [{Jirex.StatusLayoutUpdate, :t}],
      transitions: [{Jirex.TransitionUpdateDTO, :t}],
      version: {Jirex.DocumentVersion, :t}
    ]
  end
end
