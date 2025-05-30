defmodule Jirex.CreateNotificationSchemeDetails do
  @moduledoc """
  Provides struct and type for a CreateNotificationSchemeDetails
  """

  @type t :: %__MODULE__{
          description: String.t() | nil,
          name: String.t(),
          notificationSchemeEvents: [Jirex.NotificationSchemeEventDetails.t()] | nil
        }

  defstruct [:description, :name, :notificationSchemeEvents]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      description: {:string, :generic},
      name: {:string, :generic},
      notificationSchemeEvents: [{Jirex.NotificationSchemeEventDetails, :t}]
    ]
  end
end
