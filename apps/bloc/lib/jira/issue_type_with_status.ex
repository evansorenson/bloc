defmodule Jira.IssueTypeWithStatus do
  @moduledoc """
  Provides struct and type for a IssueTypeWithStatus
  """

  @type t :: %__MODULE__{
          id: String.t(),
          name: String.t(),
          self: String.t(),
          statuses: [Jira.StatusDetails.t()],
          subtask: boolean
        }

  defstruct [:id, :name, :self, :statuses, :subtask]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      id: {:string, :generic},
      name: {:string, :generic},
      self: {:string, :generic},
      statuses: [{Jira.StatusDetails, :t}],
      subtask: :boolean
    ]
  end
end
