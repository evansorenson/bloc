defmodule Jirex.FieldCreateMetadataSchema do
  @moduledoc """
  Provides struct and type for a FieldCreateMetadataSchema
  """

  @type t :: %__MODULE__{
          configuration: map | nil,
          custom: String.t() | nil,
          customId: integer | nil,
          items: String.t() | nil,
          system: String.t() | nil,
          type: String.t() | nil
        }

  defstruct [:configuration, :custom, :customId, :items, :system, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      configuration: :map,
      custom: {:string, :generic},
      customId: :integer,
      items: {:string, :generic},
      system: {:string, :generic},
      type: {:string, :generic}
    ]
  end
end
