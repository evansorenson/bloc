defmodule Jira.CreatedIssueTransition do
  @moduledoc """
  Provides struct and type for a CreatedIssueTransition
  """

  @type t :: %__MODULE__{
          errorCollection: Jira.ErrorCollection.t() | nil,
          status: integer | nil,
          warningCollection: Jira.WarningCollection.t() | nil
        }

  defstruct [:errorCollection, :status, :warningCollection]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      errorCollection: {Jira.ErrorCollection, :t},
      status: :integer,
      warningCollection: {Jira.WarningCollection, :t}
    ]
  end
end
