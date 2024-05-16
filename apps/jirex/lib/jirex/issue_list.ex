defmodule Jirex.IssueList do
  @moduledoc """
  Provides struct and type for a IssueList
  """

  @type t :: %__MODULE__{issueIds: [String.t()]}

  defstruct [:issueIds]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [issueIds: [string: :generic]]
  end
end
