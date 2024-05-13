defmodule Jira.ProjectIssueSecurityLevels do
  @moduledoc """
  Provides struct and type for a ProjectIssueSecurityLevels
  """

  @type t :: %__MODULE__{levels: [Jira.SecurityLevel.t()]}

  defstruct [:levels]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [levels: [{Jira.SecurityLevel, :t}]]
  end
end
