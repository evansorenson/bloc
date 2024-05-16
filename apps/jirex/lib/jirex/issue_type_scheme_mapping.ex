defmodule Jirex.IssueTypeSchemeMapping do
  @moduledoc """
  Provides struct and type for a IssueTypeSchemeMapping
  """

  @type t :: %__MODULE__{issueTypeId: String.t(), issueTypeSchemeId: String.t()}

  defstruct [:issueTypeId, :issueTypeSchemeId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [issueTypeId: {:string, :generic}, issueTypeSchemeId: {:string, :generic}]
  end
end
