defmodule Jirex.SimplifiedHierarchyLevel do
  @moduledoc """
  Provides struct and type for a SimplifiedHierarchyLevel
  """

  @type t :: %__MODULE__{
          aboveLevelId: integer | nil,
          belowLevelId: integer | nil,
          externalUuid: String.t() | nil,
          hierarchyLevelNumber: integer | nil,
          id: integer | nil,
          issueTypeIds: [integer] | nil,
          level: integer | nil,
          name: String.t() | nil,
          projectConfigurationId: integer | nil
        }

  defstruct [
    :aboveLevelId,
    :belowLevelId,
    :externalUuid,
    :hierarchyLevelNumber,
    :id,
    :issueTypeIds,
    :level,
    :name,
    :projectConfigurationId
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      aboveLevelId: :integer,
      belowLevelId: :integer,
      externalUuid: {:string, :uuid},
      hierarchyLevelNumber: :integer,
      id: :integer,
      issueTypeIds: [:integer],
      level: :integer,
      name: {:string, :generic},
      projectConfigurationId: :integer
    ]
  end
end
