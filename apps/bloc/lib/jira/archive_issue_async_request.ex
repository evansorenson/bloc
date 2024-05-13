defmodule Jira.ArchiveIssueAsyncRequest do
  @moduledoc """
  Provides struct and type for a ArchiveIssueAsyncRequest
  """

  @type t :: %__MODULE__{jql: String.t() | nil}

  defstruct [:jql]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [jql: {:string, :generic}]
  end
end
