defmodule Jira.NotificationSchemeEvent do
  @moduledoc """
  Provides struct and type for a NotificationSchemeEvent
  """

  @type t :: %__MODULE__{
          event: Jira.NotificationEvent.t() | nil,
          notifications: [Jira.EventNotification.t()] | nil
        }

  defstruct [:event, :notifications]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [event: {Jira.NotificationEvent, :t}, notifications: [{Jira.EventNotification, :t}]]
  end
end
