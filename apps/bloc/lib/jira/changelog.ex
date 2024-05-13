defmodule Jira.Changelog do
  @moduledoc """
  Provides struct and type for a Changelog
  """

  @type t :: %__MODULE__{
          author: Jira.ChangelogAuthor.t() | nil,
          created: DateTime.t() | nil,
          historyMetadata: Jira.ChangelogHistoryMetadata.t() | nil,
          id: String.t() | nil,
          items: [Jira.ChangeDetails.t()] | nil
        }

  defstruct [:author, :created, :historyMetadata, :id, :items]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      author: {Jira.ChangelogAuthor, :t},
      created: {:string, :date_time},
      historyMetadata: {Jira.ChangelogHistoryMetadata, :t},
      id: {:string, :generic},
      items: [{Jira.ChangeDetails, :t}]
    ]
  end
end
