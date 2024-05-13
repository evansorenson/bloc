defmodule Jira.FieldConfigurationIssueTypeItem do
  @moduledoc """
  Provides struct and type for a FieldConfigurationIssueTypeItem
  """

  @type t :: %__MODULE__{
          fieldConfigurationId: String.t(),
          fieldConfigurationSchemeId: String.t(),
          issueTypeId: String.t()
        }

  defstruct [:fieldConfigurationId, :fieldConfigurationSchemeId, :issueTypeId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      fieldConfigurationId: {:string, :generic},
      fieldConfigurationSchemeId: {:string, :generic},
      issueTypeId: {:string, :generic}
    ]
  end
end
