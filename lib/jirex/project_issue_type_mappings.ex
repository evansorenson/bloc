defmodule Jirex.ProjectIssueTypeMappings do
  @moduledoc """
  Provides struct and type for a ProjectIssueTypeMappings
  """

  @type t :: %__MODULE__{mappings: [Jirex.ProjectIssueTypeMapping.t()]}

  defstruct [:mappings]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [mappings: [{Jirex.ProjectIssueTypeMapping, :t}]]
  end
end
