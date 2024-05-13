defmodule Jira.IssuePickerSuggestions do
  @moduledoc """
  Provides struct and type for a IssuePickerSuggestions
  """

  @type t :: %__MODULE__{sections: [Jira.IssuePickerSuggestionsIssueType.t()] | nil}

  defstruct [:sections]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [sections: [{Jira.IssuePickerSuggestionsIssueType, :t}]]
  end
end
