defmodule Jirex.SecuritySchemeLevelMemberBean do
  @moduledoc """
  Provides struct and type for a SecuritySchemeLevelMemberBean
  """

  @type t :: %__MODULE__{parameter: String.t() | nil, type: String.t()}

  defstruct [:parameter, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [parameter: {:string, :generic}, type: {:string, :generic}]
  end
end
