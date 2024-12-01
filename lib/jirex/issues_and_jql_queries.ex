defmodule Jirex.IssuesAndJQLQueries do
  @moduledoc """
  Provides struct and type for a IssuesAndJQLQueries
  """

  @type t :: %__MODULE__{issueIds: [integer], jqls: [String.t()]}

  defstruct [:issueIds, :jqls]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [issueIds: [:integer], jqls: [string: :generic]]
  end
end
