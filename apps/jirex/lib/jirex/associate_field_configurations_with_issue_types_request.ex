defmodule Jirex.AssociateFieldConfigurationsWithIssueTypesRequest do
  @moduledoc """
  Provides struct and type for a AssociateFieldConfigurationsWithIssueTypesRequest
  """

  @type t :: %__MODULE__{mappings: [Jirex.FieldConfigurationToIssueTypeMapping.t()]}

  defstruct [:mappings]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [mappings: [{Jirex.FieldConfigurationToIssueTypeMapping, :t}]]
  end
end
