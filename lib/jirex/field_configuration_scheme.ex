defmodule Jirex.FieldConfigurationScheme do
  @moduledoc """
  Provides struct and type for a FieldConfigurationScheme
  """

  @type t :: %__MODULE__{description: String.t() | nil, id: String.t(), name: String.t()}

  defstruct [:description, :id, :name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [description: {:string, :generic}, id: {:string, :generic}, name: {:string, :generic}]
  end
end
