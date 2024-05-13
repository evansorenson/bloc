defmodule Jira.IssueFilterForBulkPropertyDelete do
  @moduledoc """
  Provides struct and type for a IssueFilterForBulkPropertyDelete
  """

  @type t :: %__MODULE__{currentValue: map | nil, entityIds: [integer] | nil}

  defstruct [:currentValue, :entityIds]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [currentValue: :map, entityIds: [:integer]]
  end
end
