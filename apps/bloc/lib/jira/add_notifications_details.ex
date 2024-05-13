defmodule Jira.AddNotificationsDetails do
  @moduledoc """
  Provides struct and type for a AddNotificationsDetails
  """

  @type t :: %__MODULE__{notificationSchemeEvents: [Jira.NotificationSchemeEventDetails.t()]}

  defstruct [:notificationSchemeEvents]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [notificationSchemeEvents: [{Jira.NotificationSchemeEventDetails, :t}]]
  end
end
