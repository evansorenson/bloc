defmodule Jirex.IssueMatchesForJQL do
  @moduledoc """
  Provides struct and type for a IssueMatchesForJQL
  """

  @type t :: %__MODULE__{errors: [String.t()], matchedIssues: [integer]}

  defstruct [:errors, :matchedIssues]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [errors: [string: :generic], matchedIssues: [:integer]]
  end
end
