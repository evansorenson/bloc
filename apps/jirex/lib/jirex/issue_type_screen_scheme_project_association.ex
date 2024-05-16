defmodule Jirex.IssueTypeScreenSchemeProjectAssociation do
  @moduledoc """
  Provides struct and type for a IssueTypeScreenSchemeProjectAssociation
  """

  @type t :: %__MODULE__{issueTypeScreenSchemeId: String.t() | nil, projectId: String.t() | nil}

  defstruct [:issueTypeScreenSchemeId, :projectId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [issueTypeScreenSchemeId: {:string, :generic}, projectId: {:string, :generic}]
  end
end
