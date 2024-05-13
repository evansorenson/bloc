defmodule Jira.SearchAutoCompleteFilter do
  @moduledoc """
  Provides struct and type for a SearchAutoCompleteFilter
  """

  @type t :: %__MODULE__{includeCollapsedFields: boolean | nil, projectIds: [integer] | nil}

  defstruct [:includeCollapsedFields, :projectIds]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [includeCollapsedFields: :boolean, projectIds: [:integer]]
  end
end
