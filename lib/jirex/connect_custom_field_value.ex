defmodule Jirex.ConnectCustomFieldValue do
  @moduledoc """
  Provides struct and type for a ConnectCustomFieldValue
  """

  @type t :: %__MODULE__{
          _type: String.t(),
          fieldID: integer,
          issueID: integer,
          number: number | nil,
          optionID: String.t() | nil,
          richText: String.t() | nil,
          string: String.t() | nil,
          text: String.t() | nil
        }

  defstruct [:_type, :fieldID, :issueID, :number, :optionID, :richText, :string, :text]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      _type:
        {:enum,
         [
           "StringIssueField",
           "NumberIssueField",
           "RichTextIssueField",
           "SingleSelectIssueField",
           "MultiSelectIssueField",
           "TextIssueField"
         ]},
      fieldID: :integer,
      issueID: :integer,
      number: :number,
      optionID: {:string, :generic},
      richText: {:string, :generic},
      string: {:string, :generic},
      text: {:string, :generic}
    ]
  end
end
