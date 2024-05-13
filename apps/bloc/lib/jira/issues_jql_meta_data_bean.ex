defmodule Jira.IssuesJqlMetaDataBean do
  @moduledoc """
  Provides struct and type for a IssuesJqlMetaDataBean
  """

  @type t :: %__MODULE__{
          count: integer,
          maxResults: integer,
          startAt: integer,
          totalCount: integer,
          validationWarnings: [String.t()] | nil
        }

  defstruct [:count, :maxResults, :startAt, :totalCount, :validationWarnings]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      count: :integer,
      maxResults: :integer,
      startAt: :integer,
      totalCount: :integer,
      validationWarnings: [string: :generic]
    ]
  end
end
