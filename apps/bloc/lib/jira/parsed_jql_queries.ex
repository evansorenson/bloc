defmodule Jira.ParsedJqlQueries do
  @moduledoc """
  Provides struct and type for a ParsedJqlQueries
  """

  @type t :: %__MODULE__{queries: [Jira.ParsedJqlQuery.t()]}

  defstruct [:queries]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [queries: [{Jira.ParsedJqlQuery, :t}]]
  end
end
