defmodule Jirex.IssueTypeSchemeProjectAssociation do
  @moduledoc """
  Provides struct and type for a IssueTypeSchemeProjectAssociation
  """

  @type t :: %__MODULE__{issueTypeSchemeId: String.t(), projectId: String.t()}

  defstruct [:issueTypeSchemeId, :projectId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [issueTypeSchemeId: {:string, :generic}, projectId: {:string, :generic}]
  end
end
