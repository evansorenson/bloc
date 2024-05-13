defmodule Jira.StatusMigration do
  @moduledoc """
  Provides struct and type for a StatusMigration
  """

  @type t :: %__MODULE__{newStatusReference: String.t(), oldStatusReference: String.t()}

  defstruct [:newStatusReference, :oldStatusReference]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [newStatusReference: {:string, :generic}, oldStatusReference: {:string, :generic}]
  end
end
