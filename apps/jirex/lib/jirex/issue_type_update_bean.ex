defmodule Jirex.IssueTypeUpdateBean do
  @moduledoc """
  Provides struct and type for a IssueTypeUpdateBean
  """

  @type t :: %__MODULE__{
          avatarId: integer | nil,
          description: String.t() | nil,
          name: String.t() | nil
        }

  defstruct [:avatarId, :description, :name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [avatarId: :integer, description: {:string, :generic}, name: {:string, :generic}]
  end
end
