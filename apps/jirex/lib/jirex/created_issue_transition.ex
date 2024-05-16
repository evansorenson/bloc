defmodule Jirex.CreatedIssueTransition do
  @moduledoc """
  Provides struct and type for a CreatedIssueTransition
  """

  @type t :: %__MODULE__{
          errorCollection: Jirex.ErrorCollection.t() | nil,
          status: integer | nil,
          warningCollection: Jirex.WarningCollection.t() | nil
        }

  defstruct [:errorCollection, :status, :warningCollection]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      errorCollection: {Jirex.ErrorCollection, :t},
      status: :integer,
      warningCollection: {Jirex.WarningCollection, :t}
    ]
  end
end
