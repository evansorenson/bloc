defmodule Jirex.UpdatedProjectCategory do
  @moduledoc """
  Provides struct and type for a UpdatedProjectCategory
  """

  @type t :: %__MODULE__{
          description: String.t() | nil,
          id: String.t() | nil,
          name: String.t() | nil,
          self: String.t() | nil
        }

  defstruct [:description, :id, :name, :self]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      description: {:string, :generic},
      id: {:string, :generic},
      name: {:string, :generic},
      self: {:string, :generic}
    ]
  end
end
