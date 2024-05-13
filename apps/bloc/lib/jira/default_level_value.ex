defmodule Jira.DefaultLevelValue do
  @moduledoc """
  Provides struct and type for a DefaultLevelValue
  """

  @type t :: %__MODULE__{defaultLevelId: String.t(), issueSecuritySchemeId: String.t()}

  defstruct [:defaultLevelId, :issueSecuritySchemeId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [defaultLevelId: {:string, :generic}, issueSecuritySchemeId: {:string, :generic}]
  end
end
