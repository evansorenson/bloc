defmodule Jira.BulkEditShareableEntityRequestChangeOwnerDetails do
  @moduledoc """
  Provides struct and type for a BulkEditShareableEntityRequestChangeOwnerDetails
  """

  @type t :: %__MODULE__{autofixName: boolean | nil, newOwner: String.t() | nil}

  defstruct [:autofixName, :newOwner]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [autofixName: :boolean, newOwner: {:string, :generic}]
  end
end
