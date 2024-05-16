defmodule Jirex.RemoteIssueLinkApplication do
  @moduledoc """
  Provides struct and type for a RemoteIssueLinkApplication
  """

  @type t :: %__MODULE__{name: String.t() | nil, type: String.t() | nil}

  defstruct [:name, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [name: {:string, :generic}, type: {:string, :generic}]
  end
end
