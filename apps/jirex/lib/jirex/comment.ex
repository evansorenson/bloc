defmodule Jirex.Comment do
  @moduledoc """
  Provides struct and type for a Comment
  """

  @type t :: %__MODULE__{
          author: Jirex.CommentAuthor.t() | nil,
          body: String.t() | nil,
          created: DateTime.t() | nil,
          id: String.t() | nil,
          jsdAuthorCanSeeRequest: boolean | nil,
          jsdPublic: boolean | nil,
          properties: [Jirex.EntityProperty.t()] | nil,
          renderedBody: String.t() | nil,
          self: String.t() | nil,
          updateAuthor: Jirex.CommentUpdateAuthor.t() | nil,
          updated: DateTime.t() | nil,
          visibility: Jirex.CommentVisibility.t() | nil
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
      author: {Jirex.CommentAuthor, :t},
      body: {:string, :generic},
      created: {:string, :date_time},
      id: {:string, :generic},
      jsdAuthorCanSeeRequest: :boolean,
      jsdPublic: :boolean,
      properties: [{Jirex.EntityProperty, :t}],
      renderedBody: {:string, :generic},
      self: {:string, :generic},
      updateAuthor: {Jirex.CommentUpdateAuthor, :t},
      updated: {:string, :date_time},
      visibility: {Jirex.CommentVisibility, :t}
    ]
  end
end
