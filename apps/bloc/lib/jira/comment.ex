defmodule Jira.Comment do
  @moduledoc """
  Provides struct and type for a Comment
  """

  @type t :: %__MODULE__{
          author: Jira.CommentAuthor.t() | nil,
          body: String.t() | nil,
          created: DateTime.t() | nil,
          id: String.t() | nil,
          jsdAuthorCanSeeRequest: boolean | nil,
          jsdPublic: boolean | nil,
          properties: [Jira.EntityProperty.t()] | nil,
          renderedBody: String.t() | nil,
          self: String.t() | nil,
          updateAuthor: Jira.CommentUpdateAuthor.t() | nil,
          updated: DateTime.t() | nil,
          visibility: Jira.CommentVisibility.t() | nil
        }

  defstruct [
    :author,
    :body,
    :created,
    :id,
    :jsdAuthorCanSeeRequest,
    :jsdPublic,
    :properties,
    :renderedBody,
    :self,
    :updateAuthor,
    :updated,
    :visibility
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      author: {Jira.CommentAuthor, :t},
      body: {:string, :generic},
      created: {:string, :date_time},
      id: {:string, :generic},
      jsdAuthorCanSeeRequest: :boolean,
      jsdPublic: :boolean,
      properties: [{Jira.EntityProperty, :t}],
      renderedBody: {:string, :generic},
      self: {:string, :generic},
      updateAuthor: {Jira.CommentUpdateAuthor, :t},
      updated: {:string, :date_time},
      visibility: {Jira.CommentVisibility, :t}
    ]
  end
end
