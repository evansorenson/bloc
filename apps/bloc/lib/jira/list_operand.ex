defmodule Jira.ListOperand do
  @moduledoc """
  Provides struct and type for a ListOperand
  """

  @type t :: %__MODULE__{
          encodedOperand: String.t() | nil,
          values: [Jira.FunctionOperand.t() | Jira.KeywordOperand.t() | Jira.ValueOperand.t()]
        }

  defstruct [:encodedOperand, :values]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      encodedOperand: {:string, :generic},
      values: [
        union: [{Jira.FunctionOperand, :t}, {Jira.KeywordOperand, :t}, {Jira.ValueOperand, :t}]
      ]
    ]
  end
end
