defmodule Jirex.UpdateDefaultScreenScheme do
  @moduledoc """
  Provides struct and type for a UpdateDefaultScreenScheme
  """

  @type t :: %__MODULE__{screenSchemeId: String.t()}

  defstruct [:screenSchemeId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [screenSchemeId: {:string, :generic}]
  end
end
