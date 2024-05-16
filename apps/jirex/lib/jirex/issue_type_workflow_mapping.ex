defmodule Jirex.IssueTypeWorkflowMapping do
  @moduledoc """
  Provides struct and type for a IssueTypeWorkflowMapping
  """

  @type t :: %__MODULE__{
          issueType: String.t() | nil,
          updateDraftIfNeeded: boolean | nil,
          workflow: String.t() | nil
        }

  defstruct [:issueType, :updateDraftIfNeeded, :workflow]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [issueType: {:string, :generic}, updateDraftIfNeeded: :boolean, workflow: {:string, :generic}]
  end
end
