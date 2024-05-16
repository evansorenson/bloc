defmodule Jirex.WorkflowLayout do
  @moduledoc """
  Provides struct and type for a WorkflowLayout
  """

  @type t :: %__MODULE__{x: number | nil, y: number | nil}

  defstruct [:x, :y]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [x: :number, y: :number]
  end
end
