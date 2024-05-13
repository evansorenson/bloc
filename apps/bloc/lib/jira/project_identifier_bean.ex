defmodule Jira.ProjectIdentifierBean do
  @moduledoc """
  Provides struct and type for a ProjectIdentifierBean
  """

  @type t :: %__MODULE__{id: integer | nil, key: String.t() | nil}

  defstruct [:id, :key]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [id: :integer, key: {:string, :generic}]
  end
end
