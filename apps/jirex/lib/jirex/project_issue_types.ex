defmodule Jirex.ProjectIssueTypes do
  @moduledoc """
  Provides struct and type for a ProjectIssueTypes
  """

  @type t :: %__MODULE__{issueTypes: [String.t()] | nil, project: Jirex.ProjectId.t() | nil}

  defstruct [:issueTypes, :project]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [issueTypes: [string: :generic], project: {Jirex.ProjectId, :t}]
  end
end
