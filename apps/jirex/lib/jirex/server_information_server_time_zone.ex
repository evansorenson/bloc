defmodule Jirex.ServerInformationServerTimeZone do
  @moduledoc """
  Provides struct and type for a ServerInformationServerTimeZone
  """

  @type t :: %__MODULE__{
          displayName: String.t() | nil,
          dstsavings: integer | nil,
          id: String.t() | nil,
          rawOffset: integer | nil
        }

  defstruct [:displayName, :dstsavings, :id, :rawOffset]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      displayName: {:string, :generic},
      dstsavings: :integer,
      id: {:string, :generic},
      rawOffset: :integer
    ]
  end
end
