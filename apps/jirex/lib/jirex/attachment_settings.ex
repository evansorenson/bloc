defmodule Jirex.AttachmentSettings do
  @moduledoc """
  Provides struct and type for a AttachmentSettings
  """

  @type t :: %__MODULE__{enabled: boolean | nil, uploadLimit: integer | nil}

  defstruct [:enabled, :uploadLimit]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [enabled: :boolean, uploadLimit: :integer]
  end
end
