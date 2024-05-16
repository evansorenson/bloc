defmodule Jirex.ProjectIssueSecurityLevels do
  @moduledoc """
  Provides struct and type for a ProjectIssueSecurityLevels
  """

  @type t :: %__MODULE__{levels: [Jirex.SecurityLevel.t()]}

  defstruct [:levels]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [levels: [{Jirex.SecurityLevel, :t}]]
  end
end
