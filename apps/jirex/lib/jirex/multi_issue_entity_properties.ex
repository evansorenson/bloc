defmodule Jirex.MultiIssueEntityProperties do
  @moduledoc """
  Provides struct and type for a MultiIssueEntityProperties
  """

  @type t :: %__MODULE__{issues: [Jirex.IssueEntityPropertiesForMultiUpdate.t()] | nil}

  defstruct [:issues]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [issues: [{Jirex.IssueEntityPropertiesForMultiUpdate, :t}]]
  end
end
