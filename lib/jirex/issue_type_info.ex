defmodule Jirex.IssueTypeInfo do
  @moduledoc """
  Provides struct and type for a IssueTypeInfo
  """

  @type t :: %__MODULE__{avatarId: integer | nil, id: integer | nil, name: String.t() | nil}

  defstruct [:avatarId, :id, :name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [avatarId: :integer, id: :integer, name: {:string, :generic}]
  end
end
