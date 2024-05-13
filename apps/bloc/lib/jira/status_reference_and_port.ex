defmodule Jira.StatusReferenceAndPort do
  @moduledoc """
  Provides struct and type for a StatusReferenceAndPort
  """

  @type t :: %__MODULE__{port: integer | nil, statusReference: String.t()}

  defstruct [:port, :statusReference]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [port: :integer, statusReference: {:string, :generic}]
  end
end
