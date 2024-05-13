defmodule Jira.IdSearchRequestBean do
  @moduledoc """
  Provides struct and type for a IdSearchRequestBean
  """

  @type t :: %__MODULE__{
          jql: String.t() | nil,
          maxResults: integer | nil,
          nextPageToken: String.t() | nil
        }

  defstruct [:jql, :maxResults, :nextPageToken]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [jql: {:string, :generic}, maxResults: :integer, nextPageToken: {:string, :generic}]
  end
end
