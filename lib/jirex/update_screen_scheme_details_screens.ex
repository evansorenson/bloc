defmodule Jirex.UpdateScreenSchemeDetailsScreens do
  @moduledoc """
  Provides struct and type for a UpdateScreenSchemeDetailsScreens
  """

  @type t :: %__MODULE__{
          create: String.t() | nil,
          default: String.t() | nil,
          edit: String.t() | nil,
          view: String.t() | nil
        }

  defstruct [:create, :default, :edit, :view]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      create: {:string, :generic},
      default: {:string, :generic},
      edit: {:string, :generic},
      view: {:string, :generic}
    ]
  end
end
