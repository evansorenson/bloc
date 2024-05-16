defmodule Jirex.Worklog do
  @moduledoc """
  Provides struct and type for a Worklog
  """

  @type t :: %__MODULE__{
          author: Jirex.WorklogAuthor.t() | nil,
          comment: String.t() | nil,
          created: DateTime.t() | nil,
          id: String.t() | nil,
          issueId: String.t() | nil,
          properties: [Jirex.EntityProperty.t()] | nil,
          self: String.t() | nil,
          started: DateTime.t() | nil,
          timeSpent: String.t() | nil,
          timeSpentSeconds: integer | nil,
          updateAuthor: Jirex.WorklogUpdateAuthor.t() | nil,
          updated: DateTime.t() | nil,
          visibility: Jirex.WorklogVisibility.t() | nil
        }

  defstruct [
    :author,
    :comment,
    :created,
    :id,
    :issueId,
    :properties,
    :self,
    :started,
    :timeSpent,
    :timeSpentSeconds,
    :updateAuthor,
    :updated,
    :visibility
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      author: {Jirex.WorklogAuthor, :t},
      comment: {:string, :generic},
      created: {:string, :date_time},
      id: {:string, :generic},
      issueId: {:string, :generic},
      properties: [{Jirex.EntityProperty, :t}],
      self: {:string, :uri},
      started: {:string, :date_time},
      timeSpent: {:string, :generic},
      timeSpentSeconds: :integer,
      updateAuthor: {Jirex.WorklogUpdateAuthor, :t},
      updated: {:string, :date_time},
      visibility: {Jirex.WorklogVisibility, :t}
    ]
  end
end
