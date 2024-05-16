defmodule Jirex.IssuePickerSuggestionsIssueType do
  @moduledoc """
  Provides struct and type for a IssuePickerSuggestionsIssueType
  """

  @type t :: %__MODULE__{
          id: String.t() | nil,
          issues: [Jirex.SuggestedIssue.t()] | nil,
          label: String.t() | nil,
          msg: String.t() | nil,
          sub: String.t() | nil
        }

  defstruct [:id, :issues, :label, :msg, :sub]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      id: {:string, :generic},
      issues: [{Jirex.SuggestedIssue, :t}],
      label: {:string, :generic},
      msg: {:string, :generic},
      sub: {:string, :generic}
    ]
  end
end
