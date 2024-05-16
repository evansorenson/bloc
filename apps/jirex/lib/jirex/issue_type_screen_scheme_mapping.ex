defmodule Jirex.IssueTypeScreenSchemeMapping do
  @moduledoc """
  Provides struct and type for a IssueTypeScreenSchemeMapping
  """

  @type t :: %__MODULE__{issueTypeId: String.t(), screenSchemeId: String.t()}

  defstruct [:issueTypeId, :screenSchemeId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [issueTypeId: {:string, :generic}, screenSchemeId: {:string, :generic}]
  end
end
