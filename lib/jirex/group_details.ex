defmodule Jirex.GroupDetails do
  @moduledoc """
  Provides struct and type for a GroupDetails
  """

  @type t :: %__MODULE__{groupId: String.t() | nil, name: String.t() | nil}

  defstruct [:groupId, :name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [groupId: {:string, :generic}, name: {:string, :generic}]
  end
end
