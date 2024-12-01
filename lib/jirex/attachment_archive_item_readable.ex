defmodule Jirex.AttachmentArchiveItemReadable do
  @moduledoc """
  Provides struct and type for a AttachmentArchiveItemReadable
  """

  @type t :: %__MODULE__{
          index: integer | nil,
          label: String.t() | nil,
          mediaType: String.t() | nil,
          path: String.t() | nil,
          size: String.t() | nil
        }

  defstruct [:index, :label, :mediaType, :path, :size]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      index: :integer,
      label: {:string, :generic},
      mediaType: {:string, :generic},
      path: {:string, :generic},
      size: {:string, :generic}
    ]
  end
end
