defmodule Jira.Attachment do
  @moduledoc """
  Provides struct and type for a Attachment
  """

  @type t :: %__MODULE__{
          author: Jira.AttachmentAuthor.t() | nil,
          content: String.t() | nil,
          created: DateTime.t() | nil,
          filename: String.t() | nil,
          id: String.t() | nil,
          mimeType: String.t() | nil,
          self: String.t() | nil,
          size: integer | nil,
          thumbnail: String.t() | nil
        }

  defstruct [:author, :content, :created, :filename, :id, :mimeType, :self, :size, :thumbnail]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      author: {Jira.AttachmentAuthor, :t},
      content: {:string, :generic},
      created: {:string, :date_time},
      filename: {:string, :generic},
      id: {:string, :generic},
      mimeType: {:string, :generic},
      self: {:string, :generic},
      size: :integer,
      thumbnail: {:string, :generic}
    ]
  end
end
