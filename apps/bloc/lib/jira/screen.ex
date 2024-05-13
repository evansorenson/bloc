defmodule Jira.Screen do
  @moduledoc """
  Provides struct and type for a Screen
  """

  @type t :: %__MODULE__{
          description: String.t() | nil,
          id: integer | nil,
          name: String.t() | nil,
          scope: Jira.ScreenScope.t() | nil
        }

  defstruct [:description, :id, :name, :scope]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      description: {:string, :generic},
      id: :integer,
      name: {:string, :generic},
      scope: {Jira.ScreenScope, :t}
    ]
  end
end
