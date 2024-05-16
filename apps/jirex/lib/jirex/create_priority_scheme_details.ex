defmodule Jirex.CreatePrioritySchemeDetails do
  @moduledoc """
  Provides struct and type for a CreatePrioritySchemeDetails
  """

  @type t :: %__MODULE__{
          defaultPriorityId: integer,
          description: String.t() | nil,
          mappings: Jirex.CreatePrioritySchemeDetailsMappings.t() | nil,
          name: String.t(),
          priorityIds: [integer],
          projectIds: [integer] | nil
        }

  defstruct [:defaultPriorityId, :description, :mappings, :name, :priorityIds, :projectIds]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      defaultPriorityId: :integer,
      description: {:string, :generic},
      mappings: {Jirex.CreatePrioritySchemeDetailsMappings, :t},
      name: {:string, :generic},
      priorityIds: [:integer],
      projectIds: [:integer]
    ]
  end
end
