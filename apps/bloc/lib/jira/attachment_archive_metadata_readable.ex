defmodule Jira.AttachmentArchiveMetadataReadable do
  @moduledoc """
  Provides struct and type for a AttachmentArchiveMetadataReadable
  """

  @type t :: %__MODULE__{
          entries: [Jira.AttachmentArchiveItemReadable.t()] | nil,
          id: integer | nil,
          mediaType: String.t() | nil,
          name: String.t() | nil,
          totalEntryCount: integer | nil
        }

  defstruct [:entries, :id, :mediaType, :name, :totalEntryCount]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      entries: [{Jira.AttachmentArchiveItemReadable, :t}],
      id: :integer,
      mediaType: {:string, :generic},
      name: {:string, :generic},
      totalEntryCount: :integer
    ]
  end
end
