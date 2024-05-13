defmodule Jira.JiraExpressionEvalRequestBean do
  @moduledoc """
  Provides struct and type for a JiraExpressionEvalRequestBean
  """

  @type t :: %__MODULE__{
          context: Jira.JiraExpressionEvalRequestBeanContext.t() | nil,
          expression: String.t()
        }

  defstruct [:context, :expression]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [context: {Jira.JiraExpressionEvalRequestBeanContext, :t}, expression: {:string, :generic}]
  end
end
