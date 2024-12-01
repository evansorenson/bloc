defmodule Jirex.VersionUnresolvedIssuesCount do
  @moduledoc """
  Provides struct and type for a VersionUnresolvedIssuesCount
  """

  @type t :: %__MODULE__{
          issuesCount: integer | nil,
          issuesUnresolvedCount: integer | nil,
          self: String.t() | nil
        }

  defstruct [:issuesCount, :issuesUnresolvedCount, :self]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [issuesCount: :integer, issuesUnresolvedCount: :integer, self: {:string, :uri}]
  end
end
