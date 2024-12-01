defmodule Jirex.FieldConfigurationItemsDetails do
  @moduledoc """
  Provides struct and type for a FieldConfigurationItemsDetails
  """

  @type t :: %__MODULE__{fieldConfigurationItems: [Jirex.FieldConfigurationItem.t()]}

  defstruct [:fieldConfigurationItems]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [fieldConfigurationItems: [{Jirex.FieldConfigurationItem, :t}]]
  end
end
