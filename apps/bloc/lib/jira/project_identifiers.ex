defmodule Jira.ProjectIdentifiers do
  @moduledoc """
  Provides struct and type for a ProjectIdentifiers
  """

  @type t :: %__MODULE__{id: integer, key: String.t(), self: String.t()}

  defstruct [:id, :key, :self]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [id: :integer, key: {:string, :generic}, self: {:string, :uri}]
  end
end
