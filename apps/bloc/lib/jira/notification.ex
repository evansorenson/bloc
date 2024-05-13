defmodule Jira.Notification do
  @moduledoc """
  Provides struct and type for a Notification
  """

  @type t :: %__MODULE__{
          htmlBody: String.t() | nil,
          restrict: Jira.NotificationRestrict.t() | nil,
          subject: String.t() | nil,
          textBody: String.t() | nil,
          to: Jira.NotificationTo.t() | nil
        }

  defstruct [:htmlBody, :restrict, :subject, :textBody, :to]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      htmlBody: {:string, :generic},
      restrict: {Jira.NotificationRestrict, :t},
      subject: {:string, :generic},
      textBody: {:string, :generic},
      to: {Jira.NotificationTo, :t}
    ]
  end
end
