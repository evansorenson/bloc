defmodule Jirex.AddNotificationsDetails do
  @moduledoc """
  Provides struct and type for a AddNotificationsDetails
  """

  @type t :: %__MODULE__{notificationSchemeEvents: [Jirex.NotificationSchemeEventDetails.t()]}

  defstruct [:notificationSchemeEvents]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [notificationSchemeEvents: [{Jirex.NotificationSchemeEventDetails, :t}]]
  end
end
