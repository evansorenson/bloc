defmodule Jira.WorkflowScheme do
  @moduledoc """
  Provides struct and type for a WorkflowScheme
  """

  @type t :: %__MODULE__{
          defaultWorkflow: String.t() | nil,
          description: String.t() | nil,
          draft: boolean | nil,
          id: integer | nil,
          issueTypeMappings: map | nil,
          issueTypes: map | nil,
          lastModified: String.t() | nil,
          lastModifiedUser: map | nil,
          name: String.t() | nil,
          originalDefaultWorkflow: String.t() | nil,
          originalIssueTypeMappings: map | nil,
          self: String.t() | nil,
          updateDraftIfNeeded: boolean | nil
        }

  defstruct [
    :defaultWorkflow,
    :description,
    :draft,
    :id,
    :issueTypeMappings,
    :issueTypes,
    :lastModified,
    :lastModifiedUser,
    :name,
    :originalDefaultWorkflow,
    :originalIssueTypeMappings,
    :self,
    :updateDraftIfNeeded
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      defaultWorkflow: {:string, :generic},
      description: {:string, :generic},
      draft: :boolean,
      id: :integer,
      issueTypeMappings: :map,
      issueTypes: :map,
      lastModified: {:string, :generic},
      lastModifiedUser: :map,
      name: {:string, :generic},
      originalDefaultWorkflow: {:string, :generic},
      originalIssueTypeMappings: :map,
      self: {:string, :uri},
      updateDraftIfNeeded: :boolean
    ]
  end
end
