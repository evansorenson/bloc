defmodule Jira.IssueCreateMetadata do
  @moduledoc """
  Provides struct and type for a IssueCreateMetadata
  """

  @type t :: %__MODULE__{
          expand: String.t() | nil,
          projects: [Jira.ProjectIssueCreateMetadata.t()] | nil
        }

  defstruct [:expand, :projects]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [expand: {:string, :generic}, projects: [{Jira.ProjectIssueCreateMetadata, :t}]]
  end
end
