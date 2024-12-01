defmodule Jirex.IssueArchivalSyncResponse do
  @moduledoc """
  Provides struct and type for a IssueArchivalSyncResponse
  """

  @type t :: %__MODULE__{errors: Jirex.Errors.t() | nil, numberOfIssuesUpdated: integer | nil}

  defstruct [:errors, :numberOfIssuesUpdated]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [errors: {Jirex.Errors, :t}, numberOfIssuesUpdated: :integer]
  end
end
