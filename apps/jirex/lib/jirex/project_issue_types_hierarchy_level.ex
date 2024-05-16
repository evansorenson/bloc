defmodule Jirex.ProjectIssueTypesHierarchyLevel do
  @moduledoc """
  Provides struct and type for a ProjectIssueTypesHierarchyLevel
  """

  @type t :: %__MODULE__{
          entityId: String.t() | nil,
          issueTypes: [Jirex.IssueTypeInfo.t()] | nil,
          level: integer | nil,
          name: String.t() | nil
        }

  defstruct [:entityId, :issueTypes, :level, :name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      entityId: {:string, :uuid},
      issueTypes: [{Jirex.IssueTypeInfo, :t}],
      level: :integer,
      name: {:string, :generic}
    ]
  end
end
