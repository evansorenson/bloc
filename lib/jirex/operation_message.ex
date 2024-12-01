defmodule Jirex.OperationMessage do
  @moduledoc """
  Provides struct and type for a OperationMessage
  """

  @type t :: %__MODULE__{message: String.t(), statusCode: integer}

  defstruct [:message, :statusCode]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [message: {:string, :generic}, statusCode: :integer]
  end
end
