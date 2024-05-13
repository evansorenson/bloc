defmodule Jira.IdSearchResults do
  @moduledoc """
  Provides struct and type for a IdSearchResults
  """

  @type t :: %__MODULE__{issueIds: [integer] | nil, nextPageToken: String.t() | nil}

  defstruct [:issueIds, :nextPageToken]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [issueIds: [:integer], nextPageToken: {:string, :generic}]
  end
end
