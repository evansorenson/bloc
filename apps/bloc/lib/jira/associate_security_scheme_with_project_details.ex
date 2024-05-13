defmodule Jira.AssociateSecuritySchemeWithProjectDetails do
  @moduledoc """
  Provides struct and type for a AssociateSecuritySchemeWithProjectDetails
  """

  @type t :: %__MODULE__{
          oldToNewSecurityLevelMappings: [Jira.OldToNewSecurityLevelMappingsBean.t()] | nil,
          projectId: String.t(),
          schemeId: String.t()
        }

  defstruct [:oldToNewSecurityLevelMappings, :projectId, :schemeId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      oldToNewSecurityLevelMappings: [{Jira.OldToNewSecurityLevelMappingsBean, :t}],
      projectId: {:string, :generic},
      schemeId: {:string, :generic}
    ]
  end
end
