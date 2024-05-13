defmodule Jira.JQLQueryWithUnknownUsers do
  @moduledoc """
  Provides struct and type for a JQLQueryWithUnknownUsers
  """

  @type t :: %__MODULE__{convertedQuery: String.t() | nil, originalQuery: String.t() | nil}

  defstruct [:convertedQuery, :originalQuery]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [convertedQuery: {:string, :generic}, originalQuery: {:string, :generic}]
  end
end
