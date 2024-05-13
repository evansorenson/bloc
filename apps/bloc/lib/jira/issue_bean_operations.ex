defmodule Jira.IssueBeanOperations do
  @moduledoc """
  Provides struct and type for a IssueBeanOperations
  """

  @type t :: %__MODULE__{linkGroups: [Jira.LinkGroup.t()] | nil}

  defstruct [:linkGroups]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [linkGroups: [{Jira.LinkGroup, :t}]]
  end
end
