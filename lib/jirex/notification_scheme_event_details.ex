defmodule Jirex.NotificationSchemeEventDetails do
  @moduledoc """
  Provides struct and type for a NotificationSchemeEventDetails
  """

  @type t :: %__MODULE__{
          event: Jirex.NotificationSchemeEventDetailsEvent.t(),
          notifications: [Jirex.NotificationSchemeNotificationDetails.t()]
        }

  defstruct [:event, :notifications]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      event: {Jirex.NotificationSchemeEventDetailsEvent, :t},
      notifications: [{Jirex.NotificationSchemeNotificationDetails, :t}]
    ]
  end
end
