defmodule Jirex.NotificationSchemeNotificationDetails do
  @moduledoc """
  Provides struct and type for a NotificationSchemeNotificationDetails
  """

  @type t :: %__MODULE__{notificationType: String.t(), parameter: String.t() | nil}

  defstruct [:notificationType, :parameter]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [notificationType: {:string, :generic}, parameter: {:string, :generic}]
  end
end
