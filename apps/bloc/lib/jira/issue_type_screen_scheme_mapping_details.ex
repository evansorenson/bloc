defmodule Jira.IssueTypeScreenSchemeMappingDetails do
  @moduledoc """
  Provides struct and type for a IssueTypeScreenSchemeMappingDetails
  """

  @type t :: %__MODULE__{issueTypeMappings: [Jira.IssueTypeScreenSchemeMapping.t()]}

  defstruct [:issueTypeMappings]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [issueTypeMappings: [{Jira.IssueTypeScreenSchemeMapping, :t}]]
  end
end
