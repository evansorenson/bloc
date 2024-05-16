defmodule Jirex.Changelog do
  @moduledoc """
  Provides struct and type for a Changelog
  """

  @type t :: %__MODULE__{
          author: Jirex.ChangelogAuthor.t() | nil,
          created: DateTime.t() | nil,
          historyMetadata: Jirex.ChangelogHistoryMetadata.t() | nil,
          id: String.t() | nil,
          items: [Jirex.ChangeDetails.t()] | nil
        }

  defstruct [:author, :created, :historyMetadata, :id, :items]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      author: {Jirex.ChangelogAuthor, :t},
      created: {:string, :date_time},
      historyMetadata: {Jirex.ChangelogHistoryMetadata, :t},
      id: {:string, :generic},
      items: [{Jirex.ChangeDetails, :t}]
    ]
  end
end
