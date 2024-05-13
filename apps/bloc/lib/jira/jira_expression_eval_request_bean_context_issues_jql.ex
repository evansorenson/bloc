defmodule Jira.JiraExpressionEvalRequestBeanContextIssuesJql do
  @moduledoc """
  Provides struct and type for a JiraExpressionEvalRequestBeanContextIssuesJql
  """

  @type t :: %__MODULE__{
          maxResults: integer | nil,
          query: String.t() | nil,
          startAt: integer | nil,
          validation: String.t() | nil
        }

  defstruct [:maxResults, :query, :startAt, :validation]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      maxResults: :integer,
      query: {:string, :generic},
      startAt: :integer,
      validation: {:enum, ["strict", "warn", "none"]}
    ]
  end
end
