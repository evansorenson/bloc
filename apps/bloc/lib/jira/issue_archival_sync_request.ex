defmodule Jira.IssueArchivalSyncRequest do
  @moduledoc """
  Provides struct and type for a IssueArchivalSyncRequest
  """

  @type t :: %__MODULE__{issueIdsOrKeys: [String.t()] | nil}

  defstruct [:issueIdsOrKeys]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [issueIdsOrKeys: [string: :generic]]
  end
end
