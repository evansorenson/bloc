defmodule Jira.WorkflowMetadataRestModel do
  @moduledoc """
  Provides struct and type for a WorkflowMetadataRestModel
  """

  @type t :: %__MODULE__{
          description: String.t(),
          id: String.t(),
          name: String.t(),
          usage: [Jira.SimpleUsage.t()],
          version: Jira.DocumentVersion.t()
        }

  defstruct [:description, :id, :name, :usage, :version]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      description: {:string, :generic},
      id: {:string, :generic},
      name: {:string, :generic},
      usage: [{Jira.SimpleUsage, :t}],
      version: {Jira.DocumentVersion, :t}
    ]
  end
end
