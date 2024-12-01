defmodule Jirex.AnnouncementBannerConfigurationUpdate do
  @moduledoc """
  Provides struct and type for a AnnouncementBannerConfigurationUpdate
  """

  @type t :: %__MODULE__{
          isDismissible: boolean | nil,
          isEnabled: boolean | nil,
          message: String.t() | nil,
          visibility: String.t() | nil
        }

  defstruct [:isDismissible, :isEnabled, :message, :visibility]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      isDismissible: :boolean,
      isEnabled: :boolean,
      message: {:string, :generic},
      visibility: {:string, :generic}
    ]
  end
end
