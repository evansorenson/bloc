defmodule Jirex.NotificationSchemeEvent do
  @moduledoc """
  Provides struct and type for a NotificationSchemeEvent
  """

  @type t :: %__MODULE__{
          event: Jirex.NotificationEvent.t() | nil,
          notifications: [Jirex.EventNotification.t()] | nil
        }

  defstruct [:event, :notifications]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [event: {Jirex.NotificationEvent, :t}, notifications: [{Jirex.EventNotification, :t}]]
  end
end
