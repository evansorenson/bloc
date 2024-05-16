defmodule Jirex.Avatar do
  @moduledoc """
  Provides struct and type for a Avatar
  """

  @type t :: %__MODULE__{
          fileName: String.t() | nil,
          id: String.t(),
          isDeletable: boolean | nil,
          isSelected: boolean | nil,
          isSystemAvatar: boolean | nil,
          owner: String.t() | nil,
          urls: Jirex.AvatarUrls.t() | nil
        }

  defstruct [:fileName, :id, :isDeletable, :isSelected, :isSystemAvatar, :owner, :urls]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      fileName: {:string, :generic},
      id: {:string, :generic},
      isDeletable: :boolean,
      isSelected: :boolean,
      isSystemAvatar: :boolean,
      owner: {:string, :generic},
      urls: {Jirex.AvatarUrls, :t}
    ]
  end
end
