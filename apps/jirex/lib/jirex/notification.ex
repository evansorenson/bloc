defmodule Jirex.Notification do
  @moduledoc """
  Provides struct and type for a Notification
  """

  @type t :: %__MODULE__{
          htmlBody: String.t() | nil,
          restrict: Jirex.NotificationRestrict.t() | nil,
          subject: String.t() | nil,
          textBody: String.t() | nil,
          to: Jirex.NotificationTo.t() | nil
        }

  defstruct [:htmlBody, :restrict, :subject, :textBody, :to]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      htmlBody: {:string, :generic},
      restrict: {Jirex.NotificationRestrict, :t},
      subject: {:string, :generic},
      textBody: {:string, :generic},
      to: {Jirex.NotificationTo, :t}
    ]
  end
end
