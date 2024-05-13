defmodule Jira.UiModificationIdentifiers do
  @moduledoc """
  Provides struct and type for a UiModificationIdentifiers
  """

  @type t :: %__MODULE__{id: String.t(), self: String.t()}

  defstruct [:id, :self]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [id: {:string, :generic}, self: {:string, :generic}]
  end
end
