defmodule Jirex.JqlQueryField do
  @moduledoc """
  Provides struct and type for a JqlQueryField
  """

  @type t :: %__MODULE__{
          encodedName: String.t() | nil,
          name: String.t(),
          property: [Jirex.JqlQueryFieldEntityProperty.t()] | nil
        }

  defstruct [:encodedName, :name, :property]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      encodedName: {:string, :generic},
      name: {:string, :generic},
      property: [{Jirex.JqlQueryFieldEntityProperty, :t}]
    ]
  end
end
