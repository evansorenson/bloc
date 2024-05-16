defmodule Jirex.IssueEvent do
  @moduledoc """
  Provides struct and type for a IssueEvent
  """

  @type t :: %__MODULE__{id: integer | nil, name: String.t() | nil}

  defstruct [:id, :name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [id: :integer, name: {:string, :generic}]
  end
end
