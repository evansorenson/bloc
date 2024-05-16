defmodule Jirex.PublishDraftWorkflowScheme do
  @moduledoc """
  Provides struct and type for a PublishDraftWorkflowScheme
  """

  @type t :: %__MODULE__{statusMappings: [Jirex.StatusMapping.t()] | nil}

  defstruct [:statusMappings]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [statusMappings: [{Jirex.StatusMapping, :t}]]
  end
end
