defmodule Jirex.NotificationEventTemplateEvent do
  @moduledoc """
  Provides struct and type for a NotificationEventTemplateEvent
  """

  @type t :: %__MODULE__{
          description: String.t() | nil,
          id: integer | nil,
          name: String.t() | nil,
          templateEvent: Jirex.NotificationEventTemplateEvent.t() | nil
        }

  defstruct [:description, :id, :name, :templateEvent]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      description: {:string, :generic},
      id: :integer,
      name: {:string, :generic},
      templateEvent: {Jirex.NotificationEventTemplateEvent, :t}
    ]
  end
end
