defmodule Jirex.UserContextVariable do
  @moduledoc """
  Provides struct and type for a UserContextVariable
  """

  @type t :: %__MODULE__{accountId: String.t(), type: String.t()}

  defstruct [:accountId, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [accountId: {:string, :generic}, type: {:string, :generic}]
  end
end
