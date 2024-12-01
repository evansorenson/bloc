defmodule Jirex.FieldConfigurationSchemeProjectAssociation do
  @moduledoc """
  Provides struct and type for a FieldConfigurationSchemeProjectAssociation
  """

  @type t :: %__MODULE__{fieldConfigurationSchemeId: String.t() | nil, projectId: String.t()}

  defstruct [:fieldConfigurationSchemeId, :projectId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [fieldConfigurationSchemeId: {:string, :generic}, projectId: {:string, :generic}]
  end
end
