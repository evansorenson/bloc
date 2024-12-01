defmodule Jirex.UpdateFieldConfigurationSchemeDetails do
  @moduledoc """
  Provides struct and type for a UpdateFieldConfigurationSchemeDetails
  """

  @type t :: %__MODULE__{description: String.t() | nil, name: String.t()}

  defstruct [:description, :name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [description: {:string, :generic}, name: {:string, :generic}]
  end
end
