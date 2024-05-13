defmodule Jira.SimpleLink do
  @moduledoc """
  Provides struct and type for a SimpleLink
  """

  @type t :: %__MODULE__{
          href: String.t() | nil,
          iconClass: String.t() | nil,
          id: String.t() | nil,
          label: String.t() | nil,
          styleClass: String.t() | nil,
          title: String.t() | nil,
          weight: integer | nil
        }

  defstruct [:href, :iconClass, :id, :label, :styleClass, :title, :weight]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      href: {:string, :generic},
      iconClass: {:string, :generic},
      id: {:string, :generic},
      label: {:string, :generic},
      styleClass: {:string, :generic},
      title: {:string, :generic},
      weight: :integer
    ]
  end
end
