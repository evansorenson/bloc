defmodule Jira.IssueArchivalSyncResponse do
  @moduledoc """
  Provides struct and type for a IssueArchivalSyncResponse
  """

  @type t :: %__MODULE__{errors: Jira.Errors.t() | nil, numberOfIssuesUpdated: integer | nil}

  defstruct [:errors, :numberOfIssuesUpdated]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [errors: {Jira.Errors, :t}, numberOfIssuesUpdated: :integer]
  end
end
