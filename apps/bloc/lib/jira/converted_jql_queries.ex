defmodule Jira.ConvertedJQLQueries do
  @moduledoc """
  Provides struct and type for a ConvertedJQLQueries
  """

  @type t :: %__MODULE__{
          queriesWithUnknownUsers: [Jira.JQLQueryWithUnknownUsers.t()] | nil,
          queryStrings: [String.t()] | nil
        }

  defstruct [:queriesWithUnknownUsers, :queryStrings]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      queriesWithUnknownUsers: [{Jira.JQLQueryWithUnknownUsers, :t}],
      queryStrings: [string: :generic]
    ]
  end
end
