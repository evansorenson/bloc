defmodule Jirex.MultipartFile do
  @moduledoc """
  Provides struct and type for a MultipartFile
  """

  @type t :: %__MODULE__{
          bytes: [String.t()] | nil,
          contentType: String.t() | nil,
          empty: boolean | nil,
          inputStream: map | nil,
          name: String.t() | nil,
          originalFilename: String.t() | nil,
          resource: Jirex.Resource.t() | nil,
          size: integer | nil
        }

  defstruct [
    :bytes,
    :contentType,
    :empty,
    :inputStream,
    :name,
    :originalFilename,
    :resource,
    :size
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      bytes: [string: :generic],
      contentType: {:string, :generic},
      empty: :boolean,
      inputStream: :map,
      name: {:string, :generic},
      originalFilename: {:string, :generic},
      resource: {Jirex.Resource, :t},
      size: :integer
    ]
  end
end
