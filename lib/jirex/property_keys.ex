defmodule Jirex.PropertyKeys do
  @moduledoc """
  Provides struct and type for a PropertyKeys
  """

  @type t :: %__MODULE__{keys: [Jirex.PropertyKey.t()] | nil}

  defstruct [:keys]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [keys: [{Jirex.PropertyKey, :t}]]
  end
end
