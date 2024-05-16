defmodule Jirex.Context do
  @moduledoc """
  Provides struct and type for a Context
  """

  @type t :: %__MODULE__{
          id: integer | nil,
          name: String.t() | nil,
          scope: Jirex.ContextScope.t() | nil
        }

  defstruct [:id, :name, :scope]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [id: :integer, name: {:string, :generic}, scope: {Jirex.ContextScope, :t}]
  end
end
