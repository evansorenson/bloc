defmodule Jira.PublishDraftWorkflowScheme do
  @moduledoc """
  Provides struct and type for a PublishDraftWorkflowScheme
  """

  @type t :: %__MODULE__{statusMappings: [Jira.StatusMapping.t()] | nil}

  defstruct [:statusMappings]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [statusMappings: [{Jira.StatusMapping, :t}]]
  end
end
