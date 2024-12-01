defmodule Jirex.FieldConfiguration do
  @moduledoc """
  Provides struct and type for a FieldConfiguration
  """

  @type t :: %__MODULE__{
          description: String.t(),
          id: integer,
          isDefault: boolean | nil,
          name: String.t()
        }

  defstruct [:description, :id, :isDefault, :name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      description: {:string, :generic},
      id: :integer,
      isDefault: :boolean,
      name: {:string, :generic}
    ]
  end
end
