defmodule Jirex.NotificationScheme do
  @moduledoc """
  Provides struct and type for a NotificationScheme
  """

  @type t :: %__MODULE__{
          description: String.t() | nil,
          expand: String.t() | nil,
          id: integer | nil,
          name: String.t() | nil,
          notificationSchemeEvents: [Jirex.NotificationSchemeEvent.t()] | nil,
          projects: [integer] | nil,
          scope: Jirex.NotificationSchemeScope.t() | nil,
          self: String.t() | nil
        }

  defstruct [
    :description,
    :expand,
    :id,
    :name,
    :notificationSchemeEvents,
    :projects,
    :scope,
    :self
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      description: {:string, :generic},
      expand: {:string, :generic},
      id: :integer,
      name: {:string, :generic},
      notificationSchemeEvents: [{Jirex.NotificationSchemeEvent, :t}],
      projects: [:integer],
      scope: {Jirex.NotificationSchemeScope, :t},
      self: {:string, :generic}
    ]
  end
end
