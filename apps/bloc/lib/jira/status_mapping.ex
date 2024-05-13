defmodule Jira.StatusMapping do
  @moduledoc """
  Provides struct and type for a StatusMapping
  """

  @type t :: %__MODULE__{issueTypeId: String.t(), newStatusId: String.t(), statusId: String.t()}

  defstruct [:issueTypeId, :newStatusId, :statusId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      issueTypeId: {:string, :generic},
      newStatusId: {:string, :generic},
      statusId: {:string, :generic}
    ]
  end
end
