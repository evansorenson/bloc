defmodule Jira.IssueTypesWorkflowMapping do
  @moduledoc """
  Provides struct and type for a IssueTypesWorkflowMapping
  """

  @type t :: %__MODULE__{
          defaultMapping: boolean | nil,
          issueTypes: [String.t()] | nil,
          updateDraftIfNeeded: boolean | nil,
          workflow: String.t() | nil
        }

  defstruct [:defaultMapping, :issueTypes, :updateDraftIfNeeded, :workflow]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      defaultMapping: :boolean,
      issueTypes: [string: :generic],
      updateDraftIfNeeded: :boolean,
      workflow: {:string, :generic}
    ]
  end
end
