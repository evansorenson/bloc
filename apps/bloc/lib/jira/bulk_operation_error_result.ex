defmodule Jira.BulkOperationErrorResult do
  @moduledoc """
  Provides struct and type for a BulkOperationErrorResult
  """

  @type t :: %__MODULE__{
          elementErrors: Jira.ErrorCollection.t() | nil,
          failedElementNumber: integer | nil,
          status: integer | nil
        }

  defstruct [:elementErrors, :failedElementNumber, :status]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [elementErrors: {Jira.ErrorCollection, :t}, failedElementNumber: :integer, status: :integer]
  end
end
