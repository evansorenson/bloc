defmodule Jirex.AttachmentArchiveImpl do
  @moduledoc """
  Provides struct and type for a AttachmentArchiveImpl
  """

  @type t :: %__MODULE__{
          entries: [Jirex.AttachmentArchiveEntry.t()] | nil,
          totalEntryCount: integer | nil
        }

  defstruct [:entries, :totalEntryCount]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [entries: [{Jirex.AttachmentArchiveEntry, :t}], totalEntryCount: :integer]
  end
end
