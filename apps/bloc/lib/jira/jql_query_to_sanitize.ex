defmodule Jira.JqlQueryToSanitize do
  @moduledoc """
  Provides struct and type for a JqlQueryToSanitize
  """

  @type t :: %__MODULE__{accountId: String.t() | nil, query: String.t()}

  defstruct [:accountId, :query]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [accountId: {:string, :generic}, query: {:string, :generic}]
  end
end
