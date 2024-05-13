defmodule Jira.ScreenSchemeScreens do
  @moduledoc """
  Provides struct and type for a ScreenSchemeScreens
  """

  @type t :: %__MODULE__{
          create: integer | nil,
          default: integer | nil,
          edit: integer | nil,
          view: integer | nil
        }

  defstruct [:create, :default, :edit, :view]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [create: :integer, default: :integer, edit: :integer, view: :integer]
  end
end
