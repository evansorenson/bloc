defmodule Jirex.OrderOfIssueTypes do
  @moduledoc """
  Provides struct and type for a OrderOfIssueTypes
  """

  @type t :: %__MODULE__{
          after: String.t() | nil,
          issueTypeIds: [String.t()],
          position: String.t() | nil
        }

  defstruct [:after, :issueTypeIds, :position]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      after: {:string, :generic},
      issueTypeIds: [string: :generic],
      position: {:enum, ["First", "Last"]}
    ]
  end
end
