defmodule Jira.Worklog do
  @moduledoc """
  Provides struct and type for a Worklog
  """

  @type t :: %__MODULE__{
          author: Jira.WorklogAuthor.t() | nil,
          comment: String.t() | nil,
          created: DateTime.t() | nil,
          id: String.t() | nil,
          issueId: String.t() | nil,
          properties: [Jira.EntityProperty.t()] | nil,
          self: String.t() | nil,
          started: DateTime.t() | nil,
          timeSpent: String.t() | nil,
          timeSpentSeconds: integer | nil,
          updateAuthor: Jira.WorklogUpdateAuthor.t() | nil,
          updated: DateTime.t() | nil,
          visibility: Jira.WorklogVisibility.t() | nil
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
      author: {Jira.WorklogAuthor, :t},
      comment: {:string, :generic},
      created: {:string, :date_time},
      id: {:string, :generic},
      issueId: {:string, :generic},
      properties: [{Jira.EntityProperty, :t}],
      self: {:string, :uri},
      started: {:string, :date_time},
      timeSpent: {:string, :generic},
      timeSpentSeconds: :integer,
      updateAuthor: {Jira.WorklogUpdateAuthor, :t},
      updated: {:string, :date_time},
      visibility: {Jira.WorklogVisibility, :t}
    ]
  end
end
