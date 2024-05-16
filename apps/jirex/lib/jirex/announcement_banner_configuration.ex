defmodule Jirex.AnnouncementBannerConfiguration do
  @moduledoc """
  Provides struct and type for a AnnouncementBannerConfiguration
  """

  @type t :: %__MODULE__{
          hashId: String.t() | nil,
          isDismissible: boolean | nil,
          isEnabled: boolean | nil,
          message: String.t() | nil,
          visibility: String.t() | nil
        }

  defstruct [:hashId, :isDismissible, :isEnabled, :message, :visibility]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      hashId: {:string, :generic},
      isDismissible: :boolean,
      isEnabled: :boolean,
      message: {:string, :generic},
      visibility: {:enum, ["PUBLIC", "PRIVATE"]}
    ]
  end
end
