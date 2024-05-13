defmodule Jira.ProjectIssueTypeMapping do
  @moduledoc """
  Provides struct and type for a ProjectIssueTypeMapping
  """

  @type t :: %__MODULE__{issueTypeId: String.t(), projectId: String.t()}

  defstruct [:issueTypeId, :projectId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [issueTypeId: {:string, :generic}, projectId: {:string, :generic}]
  end
end
