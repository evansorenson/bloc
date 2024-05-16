defmodule Jirex.AttachmentArchiveEntry do
  @moduledoc """
  Provides struct and type for a AttachmentArchiveEntry
  """

  @type t :: %__MODULE__{
          abbreviatedName: String.t() | nil,
          entryIndex: integer | nil,
          mediaType: String.t() | nil,
          name: String.t() | nil,
          size: integer | nil
        }

  defstruct [:abbreviatedName, :entryIndex, :mediaType, :name, :size]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      abbreviatedName: {:string, :generic},
      entryIndex: :integer,
      mediaType: {:string, :generic},
      name: {:string, :generic},
      size: :integer
    ]
  end
end
