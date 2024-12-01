defmodule Jirex.IssueSecuritySchemeToProjectMapping do
  @moduledoc """
  Provides struct and type for a IssueSecuritySchemeToProjectMapping
  """

  @type t :: %__MODULE__{issueSecuritySchemeId: String.t() | nil, projectId: String.t() | nil}

  defstruct [:issueSecuritySchemeId, :projectId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [issueSecuritySchemeId: {:string, :generic}, projectId: {:string, :generic}]
  end
end
