defmodule Jirex.BulkIssuePropertyUpdateRequestFilter do
  @moduledoc """
  Provides struct and type for a BulkIssuePropertyUpdateRequestFilter
  """

  @type t :: %__MODULE__{
          currentValue: map | nil,
          entityIds: [integer] | nil,
          hasProperty: boolean | nil
        }

  defstruct [:currentValue, :entityIds, :hasProperty]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [currentValue: :map, entityIds: [:integer], hasProperty: :boolean]
  end
end
