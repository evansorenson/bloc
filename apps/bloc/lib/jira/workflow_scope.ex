defmodule Jira.WorkflowScope do
  @moduledoc """
  Provides struct and type for a WorkflowScope
  """

  @type t :: %__MODULE__{project: Jira.ProjectId.t() | nil, type: String.t()}

  defstruct [:project, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [project: {Jira.ProjectId, :t}, type: {:enum, ["PROJECT", "GLOBAL"]}]
  end
end
