defmodule Jira.RemoteIssueLinkIdentifies do
  @moduledoc """
  Provides struct and type for a RemoteIssueLinkIdentifies
  """

  @type t :: %__MODULE__{id: integer | nil, self: String.t() | nil}

  defstruct [:id, :self]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [id: :integer, self: {:string, :generic}]
  end
end
