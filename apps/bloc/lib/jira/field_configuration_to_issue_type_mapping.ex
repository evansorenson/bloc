defmodule Jira.FieldConfigurationToIssueTypeMapping do
  @moduledoc """
  Provides struct and type for a FieldConfigurationToIssueTypeMapping
  """

  @type t :: %__MODULE__{fieldConfigurationId: String.t(), issueTypeId: String.t()}

  defstruct [:fieldConfigurationId, :issueTypeId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [fieldConfigurationId: {:string, :generic}, issueTypeId: {:string, :generic}]
  end
end
