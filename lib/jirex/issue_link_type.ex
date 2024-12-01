defmodule Jirex.IssueLinkType do
  @moduledoc """
  Provides struct and types for a IssueLinkType
  """

  @type t :: %__MODULE__{
          id: String.t() | nil,
          inward: String.t() | nil,
          name: String.t() | nil,
          outward: String.t() | nil,
          self: String.t() | nil
        }

  defstruct [:id, :inward, :name, :outward, :self]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      id: {:string, :generic},
      inward: {:string, :generic},
      name: {:string, :generic},
      outward: {:string, :generic},
      self: {:string, :uri}
    ]
  end
end
