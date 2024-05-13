defmodule Jira.JiraExpressionValidationError do
  @moduledoc """
  Provides struct and type for a JiraExpressionValidationError
  """

  @type t :: %__MODULE__{
          column: integer | nil,
          expression: String.t() | nil,
          line: integer | nil,
          message: String.t(),
          type: String.t()
        }

  defstruct [:column, :expression, :line, :message, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      column: :integer,
      expression: {:string, :generic},
      line: :integer,
      message: {:string, :generic},
      type: {:enum, ["syntax", "type", "other"]}
    ]
  end
end
