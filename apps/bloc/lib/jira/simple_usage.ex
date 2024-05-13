defmodule Jira.SimpleUsage do
  @moduledoc """
  Provides struct and type for a SimpleUsage
  """

  @type t :: %__MODULE__{issueTypeIds: [String.t()], projectId: String.t()}

  defstruct [:issueTypeIds, :projectId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [issueTypeIds: [string: :generic], projectId: {:string, :generic}]
  end
end
