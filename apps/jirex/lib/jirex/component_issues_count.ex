defmodule Jirex.ComponentIssuesCount do
  @moduledoc """
  Provides struct and type for a ComponentIssuesCount
  """

  @type t :: %__MODULE__{issueCount: integer | nil, self: String.t() | nil}

  defstruct [:issueCount, :self]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [issueCount: :integer, self: {:string, :uri}]
  end
end
