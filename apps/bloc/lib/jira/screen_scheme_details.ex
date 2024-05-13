defmodule Jira.ScreenSchemeDetails do
  @moduledoc """
  Provides struct and type for a ScreenSchemeDetails
  """

  @type t :: %__MODULE__{
          description: String.t() | nil,
          name: String.t(),
          screens: Jira.ScreenSchemeDetailsScreens.t()
        }

  defstruct [:description, :name, :screens]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      description: {:string, :generic},
      name: {:string, :generic},
      screens: {Jira.ScreenSchemeDetailsScreens, :t}
    ]
  end
end
