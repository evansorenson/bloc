defmodule Jirex.FieldConfigurationItem do
  @moduledoc """
  Provides struct and type for a FieldConfigurationItem
  """

  @type t :: %__MODULE__{
          description: String.t() | nil,
          id: String.t(),
          isHidden: boolean | nil,
          isRequired: boolean | nil,
          renderer: String.t() | nil
        }

  defstruct [:description, :id, :isHidden, :isRequired, :renderer]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      description: {:string, :generic},
      id: {:string, :generic},
      isHidden: :boolean,
      isRequired: :boolean,
      renderer: {:string, :generic}
    ]
  end
end
