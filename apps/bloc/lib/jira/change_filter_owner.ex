defmodule Jira.ChangeFilterOwner do
  @moduledoc """
  Provides struct and type for a ChangeFilterOwner
  """

  @type t :: %__MODULE__{accountId: String.t()}

  defstruct [:accountId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [accountId: {:string, :generic}]
  end
end
